import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/models/schedule_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/pop_up_delete.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class DetailScheduleController extends GetxController {
  var isLoading = false;
  var isError = false;
  var error = "";
  var list = <ScheduleModel>[];
  var listChecked = 0;
  var allChecked = false;
  var date = DateFormat("yyyy-MM-dd").format(Get.arguments);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    list = [];
    listChecked = 0;
    allChecked = false;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.detailschedulepath,
        queryParameters: {"date": date},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        list = result['data']
            .map<ScheduleModel>((v) => ScheduleModel.fromJson(v))
            .toList();
      } else {
        list = [];
      }
      isLoading = false;
      update();
    } catch (e) {
      isError = true;
      error = e.toString();
      isLoading = false;
      update();
    }
  }

  void editSchedule() {
    var data = list.where((e) => e.isChecked!).toList();
    Get.toNamed(
      Routes.ADD_SCHEDULE,
      arguments: {"data": data},
    )!
        .then((value) => getData());
  }

  void setCardChecked(int? index) {
    list[index!].isChecked = !list[index].isChecked!;
    update();
    countCheckedList();
  }

  void setAllChecked() {
    for (var e in list) {
      if (allChecked) {
        e.isChecked = false;
      } else {
        e.isChecked = true;
      }
    }
    update();
    countCheckedList();
  }

  void countCheckedList() {
    listChecked = 0;
    allChecked = false;
    for (var e in list) {
      if (e.isChecked!) {
        listChecked++;
      }
    }
    if (listChecked == list.length) {
      allChecked = true;
    }
    update();
  }

  void confirmDelete() {
    Get.dialog(PopUpDelete(
      title: "Hapus Jadwal",
      detail: "Apakah kamu yakin ingin menghapus data jadwal?",
      onTap: () => doDelete(),
    ));
  }

  void doDelete() async {
    Get.back();
    loading(text: "Silahkan tunggu.\nData-data jadwal\nsedang diproses.");
    try {
      final response = await Api().deleteWithToken(
        path: AppVariable.schedulepath,
        data: {
          "_id": [...list.where((v) => v.isChecked!).map((e) => e.id)]
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        Get.to(PageSuccess(
          title: "Jadwal Dihapus",
          subtitle: "Penghapusan Jadwal Selesai",
          detail:
              "Data jadwal berhasil dihapus. Silahkan lihat daftar jadwal sekarang.",
          textBtn: "Lihat Jadwal",
          path: AppIllustration.illustrationdatadelete,
          onTap: () {
            Get.until((route) => Get.currentRoute == Routes.DETAIL_SCHEDULE);
            getData();
          },
        ));
      } else {
        Get.back();
        snackbarDanger(message: result["message"]);
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: "$e");
    }
  }
}
