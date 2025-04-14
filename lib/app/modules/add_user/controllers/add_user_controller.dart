import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/models/user_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/modules/add_user/views/confirm_user_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class AddUserController extends GetxController {
  var nameController = TextEditingController();
  var noTelpController = TextEditingController();
  var passwordController = TextEditingController();
  var userTypeController = TextEditingController(text: "Admin");
  var simNumberController = TextEditingController();
  var key = GlobalKey<FormState>();
  var arg = Get.arguments;
  var isComplete = false;
  var isEdit = false;
  var title = "Isi Data Pengguna";
  var data = UserModel();
  var isLoading = false;

  @override
  void onInit() {
    if (arg != null) {
      data = arg as UserModel;
      nameController.text = data.name!;
      noTelpController.text = data.phone!;
      passwordController.text = "";
      userTypeController.text = data.userType!;
      simNumberController.text = data.simNumber!;
      isEdit = true;
      isComplete = true;
      title = "Ubah Data Pengguna";
      update();
    }
    super.onInit();
  }

  void selectUserType({String? v}) {
    userTypeController.text = v!;
    update();
  }

  void onChange() {
    isComplete = true;
    update();
  }

  void confirmSubmit() {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      if (isEdit) {
        handleSubmit();
      } else {
        Get.to(const ConfirmUserView());
      }
    }
  }

  void handleSubmit() async {
    isLoading = true;
    update();
    loading(text: "Silahkan tunggu.\nData-data pengguna\nsedang diproses.");
    if (isEdit) {
      try {
        final response = await Api().putWithToken(
          path: AppVariable.userpath,
          queryParameters: {"_id": data.id},
          data: {
            "nama": nameController.text,
            "nomor_telepon": noTelpController.text,
            "password": passwordController.text,
            "user_type": userTypeController.text,
            "nomor_sim": simNumberController.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Data Pengguna Diubah",
            subtitle: "Perubahan Pengguna Selesai",
            detail:
                "Data pengguna berhasil diubah. Silahkan lihat daftar pengguna sekarang.",
            textBtn: "Lihat Pengguna",
            path: AppIllustration.illustrationedituser,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.USERS);
              }
            },
          ));
        } else {
          Get.back();
          snackbarDanger(message: result["message"]);
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      } finally {
        setIsLoading();
      }
    } else {
      try {
        final response = await Api().postWithToken(
          path: AppVariable.userpath,
          data: {
            "nama": nameController.text,
            "nomor_telepon": noTelpController.text,
            "password": passwordController.text,
            "user_type": userTypeController.text,
            "nomor_sim": simNumberController.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Pengguna Ditambahkan",
            subtitle: "Penambahan Pengguna Selesai",
            detail:
                "Pengguna berhasil ditambahkan. Silahkan lihat daftar pengguna sekarang.",
            textBtn: "Lihat Pengguna",
            path: AppIllustration.illustrationedituser,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.USERS);
              }
            },
          ));
        } else {
          Get.back();
          snackbarDanger(message: result["message"]);
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: "$e");
      } finally {
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
