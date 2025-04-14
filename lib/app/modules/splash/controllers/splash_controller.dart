import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:latransportindo/app/data/models/auth_model.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class SplashController extends GetxController {
  var box = GetStorage();
  var authModel = AuthModel();
  @override
  void onReady() {
    Timer(
      const Duration(milliseconds: 2700),
      () => checkLogin(),
    );

    super.onReady();
  }

  void checkLogin() {
    // box.remove("is_login");
    // box.remove("token");
    bool isLogin = box.read('is_login') ?? false;
    if (!isLogin) {
      Get.offAllNamed(Routes.SIGNIN);
    } else {
      var token = box.read("token");
      authModel = AuthModel.fromJson(JwtDecoder.decode(token));
      print(authModel.userType);
      switch (authModel.userType) {
        case "Admin":
          Get.offAllNamed(Routes.ADMIN_HOME);
          break;
        case "Pengemudi":
          Get.offAllNamed(Routes.USER_HOME);
          break;
        default:
      }
    }
  }
}
