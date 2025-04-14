import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/pop_up_succes.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class CreateNewPasswordController extends GetxController {
  var box = GetStorage();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var key = GlobalKey<FormState>();
  var isLoading = false;

  void onSubmit() async {
    if (key.currentState!.validate()) {
      isLoading = true;
      update();
      loading(text: "Silahkan tunggu.\nData-data pengguna\nsedang diproses.");
      try {
        final response = await Api().postWithToken(
          path: AppVariable.createpasswordpath,
          data: {
            "password": passwordController.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.dialog(PopUpSuccess(
            title: "Perubahan Berhasil",
            detail:
                "Silahkan login kembali dengan menggunakan kata sandi yang baru.",
            onTap: () {
              box.remove("is_login");
              box.remove("token");
              update();
              // Get.until((route) => Get.currentRoute == Routes.SIGNIN);
              Get.offAllNamed(Routes.SIGNIN);
            },
          ));
        } else {
          Get.back();
          snackbarDanger(message: result["message"]);
          setIsLoading();
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
        setIsLoading();
      }
    }
  }

  void setIsLoading() {
    Timer(const Duration(seconds: 2), () {
      isLoading = false;
      update();
    });
  }
}
