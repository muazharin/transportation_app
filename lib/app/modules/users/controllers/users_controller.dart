import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:latransportindo/app/data/models/user_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/pop_up_delete.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class UsersController extends GetxController {
  var isLoading = false;
  var isError = false;
  var error = "";
  var page = 1;
  var isSearch = false;
  var isFilter = false;
  var list = <UserModel>[];
  var userType = TextEditingController();
  var searchController = TextEditingController();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));

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
    page = 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.userpath,
        queryParameters: {
          "search": searchController.text,
          "user_type": userType.text,
          "page": page,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        list = result['data']
            .map<UserModel>((v) => UserModel.fromJson(v))
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

  void onSearch({String? v}) {
    debouncer.call(() {
      isSearch = true;
      getData();
    });
  }

  void selectUserType({String? v}) {
    if (v == userType.text) {
      userType.text = "";
    } else {
      userType.text = v!;
    }
    isSearch = true;
    update();
    getData();
  }

  void setFilter() {
    isFilter = !isFilter;
    update();
  }

  void loadMore() async {
    page = page + 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.userpath,
        queryParameters: {
          "search": searchController.text,
          "user_type": userType.text,
          "page": page,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var newList = result['data']
            .map<UserModel>((v) => UserModel.fromJson(v))
            .toList();
        list.addAll(newList);
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  void onRefresh() {
    isSearch = false;
    isFilter = false;
    userType.text = "";
    searchController.text = "";
    update();
    getData();
  }

  void editUser({UserModel? data}) {
    Get.toNamed(
      Routes.ADD_USER,
      arguments: data,
    )!
        .then((value) => onRefresh());
  }

  void deleteUser({UserModel? data}) {
    Get.dialog(PopUpDelete(
      title: "Hapus Pengguna",
      detail: "Apakah kamu yakin ingin menghapus data pengguna?",
      onTap: () => doDelete(data: data),
    ));
  }

  void doDelete({UserModel? data}) async {
    Get.back();
    loading(text: "Silahkan tunggu.\nData-data pengguna\nsedang diproses.");
    try {
      final response = await Api().deleteWithToken(
        path: AppVariable.userpath,
        queryParameters: {"_id": data!.id},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        Get.to(PageSuccess(
          title: "Pengguna Dihapus",
          subtitle: "Penghapusan Pengguna Selesai",
          detail:
              "Data pengguna berhasil dihapus. Silahkan lihat daftar pengguna sekarang.",
          textBtn: "Lihat Pengguna",
          path: AppIllustration.illustrationdatadelete,
          onTap: () {
            Get.until((route) => Get.currentRoute == Routes.USERS);
            onRefresh();
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
