import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:latransportindo/app/data/models/auth_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class SigninController extends GetxController {
  var box = GetStorage();
  var authModel = AuthModel();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var key = GlobalKey<FormState>();
  var isLoading = false;

  void onSubmit() async {
    if (key.currentState!.validate()) {
      isLoading = true;
      update();
      loading(text: "Silahkan tunggu.\nData-data pengguna\nsedang diproses.");
      try {
        final response = await Api().postWithoutToken(
          path: AppVariable.signin,
          data: {
            "nomor_telepon": phoneController.text,
            "password": passwordController.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          box.write("token", result["data"]["token"]);
          var token = box.read("token");
          authModel = AuthModel.fromJson(JwtDecoder.decode(token.toString()));
          if (authModel.isNew!) {
            Get.toNamed(Routes.CREATE_NEW_PASSWORD);
          } else {
            checkUserType(authModel: authModel);
          }
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

  void checkUserType({AuthModel? authModel}) {
    box.write("is_login", true);
    update();
    switch (authModel!.userType!) {
      case "Admin":
        Get.offAllNamed(Routes.ADMIN_HOME, arguments: true);
        break;
      case "Pengemudi":
        Get.offAllNamed(Routes.USER_HOME, arguments: true);
        break;
      default:
    }
  }

  void onChange() {
    update();
  }

  void setIsLoading() {
    Timer(const Duration(seconds: 2), () {
      isLoading = false;
      update();
    });
  }
}
