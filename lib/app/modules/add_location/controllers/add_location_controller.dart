import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/models/customer_model.dart';
import 'package:latransportindo/app/data/models/location_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/modules/add_location/views/confirm_location_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class AddLocationController extends GetxController {
  var name = TextEditingController();
  var address = TextEditingController();
  var customer = TextEditingController();
  var customerModel = CustomerModel();
  var status = TextEditingController(text: "Aktif");
  var key = GlobalKey<FormState>();
  var arg = Get.arguments;
  var isComplete = false;
  var isEdit = false;
  var title = "Isi Data Lokasi";
  var data = LocationModel();
  var isLoading = false;

  @override
  void onInit() {
    if (arg != null) {
      data = arg as LocationModel;
      name.text = data.name!;
      address.text = data.address!;
      customer.text = data.customer!.name!;
      customerModel = data.customer!;
      status.text = data.status!;
      isEdit = true;
      isComplete = true;
      title = "Ubah Data Lokasi";
      update();
    }
    super.onInit();
  }

  void onChange() {
    isComplete = true;
    update();
  }

  void setCustomer({CustomerModel? v}) {
    customerModel = v!;
    customer.text = v.name!;
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
        Get.to(const ConfirmLocationView());
      }
    }
  }

  void handleSubmit() async {
    isLoading = true;
    update();
    loading(text: "Silahkan tunggu.\nData-data lokasi\nsedang diproses.");
    if (isEdit) {
      try {
        final response = await Api().putWithToken(
          path: AppVariable.locationpath,
          queryParameters: {"_id": data.id},
          data: {
            "nama": name.text,
            "alamat": address.text,
            "pelanggan_id": customerModel.id,
            "status": status.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Data Lokasi Diubah",
            subtitle: "Perubahan Lokasi Selesai",
            detail:
                "Lokasi berhasil diubah. Silahkan lihat daftar lokasi sekarang.",
            textBtn: "Lihat Lokasi",
            path: AppIllustration.illustrationeditlocation,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.LOCATIONS);
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
          path: AppVariable.locationpath,
          data: {
            "nama": name.text,
            "alamat": address.text,
            "pelanggan_id": customerModel.id,
            "status": status.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Lokasi Ditambahkan",
            subtitle: "Penambahan Lokasi Selesai",
            detail:
                "Lokasi berhasil ditambahkan. Silahkan lihat daftar lokasi sekarang.",
            textBtn: "Lihat Lokasi",
            path: AppIllustration.illustrationeditlocation,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.LOCATIONS);
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
