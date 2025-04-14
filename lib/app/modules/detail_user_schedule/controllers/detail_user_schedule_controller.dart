import 'dart:convert';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/models/detail_user_schedule.dart';
import 'package:latransportindo/app/data/models/my_schedule_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class DetailUserScheduleController extends GetxController {
  var isLoading = true;
  var isError = true;
  var error = "";

  var data = DetailUserScheduleModel();
  var arg = Get.arguments as MyScheduleModel;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.detailuserschedulepath,
        queryParameters: {"_id": arg.id},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        data = DetailUserScheduleModel.fromJson(result['data']);
      } else {
        data = DetailUserScheduleModel();
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

  String getIdLocation() {
    for (var i = 0; i < data.location!.length; i++) {
      if (data.location![i].statusLoading == null) {
        return data.location![i].idLocation!;
      }
    }
    return "";
  }

  void isTodayOrFuture(String? v) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day);
    final dateTask = data.tanggalTugas!;
    if (dateTime
        .isAfter(DateTime(dateTask.year, dateTask.month, dateTask.day - 1))) {
      handleSubmit(v);
    } else {
      snackbarDanger(message: "Status belum bisa diupdate");
    }
  }

  void handleSubmit(String? v) async {
    loading(text: "Silahkan tunggu.\nData jadwal Anda\nsedang diproses.");
    try {
      final response = await Api().putWithToken(
        path: AppVariable.scheduleuserpath,
        data: {
          "id_schedule": data.idSchedule,
          "id_location": getIdLocation(),
          "status": v,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        if (result['is_the_last']) {
          Get.to(PageSuccess(
            title: "Jadwal Dibuat",
            subtitle: "Selamat, Pekerjaan Telah Selesai",
            detail:
                "Pengiriman telah diselesaikan. Silahkan lihat status pengiriman sekarang.",
            textBtn: "Lihat Detail Pengiriman",
            path: AppIllustration.illustrationjobdone,
            onTap: () {
              getData();
              Get.until(
                  (route) => Get.currentRoute == Routes.DETAIL_USER_SCHEDULE);
            },
          ));
        } else {
          Get.back();
          getData();
        }
      } else {
        print(result["message"]);
        Get.back();
        snackbarDanger(message: result["message"]);
      }
    } catch (e) {
      print(e);
      Get.back();
      snackbarDanger(message: "$e");
    }
  }
}
