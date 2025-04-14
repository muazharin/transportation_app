import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/models/customer_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/modules/add_customer/views/confirm_customer_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class AddCustomerController extends GetxController {
  var name = TextEditingController();
  var noTelp = TextEditingController();
  var email = TextEditingController();
  var status = TextEditingController(text: "Aktif");
  var key = GlobalKey<FormState>();
  var arg = Get.arguments;
  var data = CustomerModel();
  var isComplete = false;
  var isEdit = false;
  var title = "Isi Data Pelanggan";
  var isLoading = false;

  @override
  void onInit() {
    if (arg != null) {
      data = arg as CustomerModel;
      name.text = data.name!;
      noTelp.text = data.phoneNumber!;
      email.text = data.email!;
      status.text = data.status!;
      isEdit = true;
      isComplete = true;
      title = "Ubah Data Pelanggan";
      update();
    }
    super.onInit();
  }

  void onChange() {
    isComplete = true;
    update();
  }

  void selectStatus({String? v}) {
    status.text = v!;
    update();
  }

  void confirmSubmit() {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      if (isEdit) {
        handleSubmit();
      } else {
        Get.to(const ConfirmCustomerView());
      }
    }
  }

  void handleSubmit() async {
    isLoading = true;
    update();
    loading(text: "Silahkan tunggu.\nData-data pelanggan\nsedang diproses.");
    if (isEdit) {
      try {
        final response = await Api().putWithToken(
          path: AppVariable.customerpath,
          queryParameters: {"_id": data.id},
          data: {
            "nama": name.text,
            "nomor_telepon": noTelp.text,
            "email": email.text,
            "status": status.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Data Pelanggan Ditambahkan",
            subtitle: "Perubahan Pelanggan Selesai",
            detail:
                "Pelanggan berhasil diubah. Silahkan lihat daftar pelanggan sekarang.",
            textBtn: "Lihat Pelanggan",
            path: AppIllustration.illustrationeditcustomer,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.CUSTOMERS);
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
          path: AppVariable.customerpath,
          data: {
            "nama": name.text,
            "nomor_telepon": noTelp.text,
            "email": email.text,
            "status": status.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Pelanggan Ditambahkan",
            subtitle: "Penambahan Pelanggan Selesai",
            detail:
                "Pelanggan berhasil ditambahkan. Silahkan lihat daftar pelanggan sekarang.",
            textBtn: "Lihat Pelanggan",
            path: AppIllustration.illustrationeditcustomer,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.CUSTOMERS);
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
