import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/widgets/pop_up_succes.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class UserHomeController extends GetxController {
  var index = 0;
  var arg = Get.arguments;

  @override
  void onInit() {
    if (arg != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(const PopUpSuccess(
          title: "Login Sukses",
          detail: "Selamat! Anda berhasil masuk ke sistem.",
          isShowButton: false,
          isShowIcons: true,
        ));
      });
    }
    super.onInit();
  }

  void setIndex(int? i) {
    if (i == 2) {
      Get.toNamed(Routes.PROFILE);
    } else {
      index = i!;
      update();
    }
  }
}
