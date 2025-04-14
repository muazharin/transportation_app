import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/models/car_type_model.dart';
import 'package:latransportindo/app/data/models/vehicle_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/modules/add_vehicle/views/confirm_vehicle_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class AddVehicleController extends GetxController {
  var policeNumber = TextEditingController();
  var carType = TextEditingController();
  var note = TextEditingController();
  var doorNumber = TextEditingController();
  var kir = TextEditingController();
  var stnk = TextEditingController();
  var status = TextEditingController(text: "Aktif");
  var key = GlobalKey<FormState>();
  var isComplete = false;
  var carTypeModel = CarTypeModel();
  var arg = Get.arguments;
  var data = VehicleModel();
  var isEdit = false;
  var title = "Isi Data Kendaraan";
  var isLoading = false;

  @override
  void onInit() {
    if (arg != null) {
      data = arg as VehicleModel;
      policeNumber.text = data.policeNumber!;
      carType.text = data.carType!.name!;
      carTypeModel = data.carType!;
      note.text = data.note!;
      doorNumber.text = data.doorNumber!;
      kir.text = data.kir!;
      stnk.text = data.stnk!;
      status.text = data.status!;
      isEdit = true;
      isComplete = true;
      title = "Ubah Data Kendaraan";
      update();
    }
    super.onInit();
  }

  void onChange() {
    isComplete = true;
    update();
  }

  void setCarType({CarTypeModel? v}) {
    carTypeModel = v!;
    carType.text = v.name!;
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
        Get.to(const ConfirmVehicleView());
      }
    }
  }

  void handleSubmit() async {
    isLoading = true;
    update();
    loading(text: "Silahkan tunggu.\nData-data kendaraan\nsedang diproses.");
    if (isEdit) {
      try {
        final response = await Api().putWithToken(
          path: AppVariable.vehiclepath,
          queryParameters: {"_id": data.id},
          data: {
            "nomor_polisi": policeNumber.text.toLowerCase(),
            "tipe_kendaraan_id": carTypeModel.id,
            "keterangan": note.text,
            "nomor_pintu": doorNumber.text,
            "nomor_kir": kir.text,
            "nomor_stnk": stnk.text,
            "status": status.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Data Kendaraan Diubah",
            subtitle: "Perubahan Kendaraan Selesai",
            detail:
                "Kendaraan berhasil diubah. Silahkan lihat daftar kendaraan sekarang.",
            textBtn: "Lihat Kendaraan",
            path: AppIllustration.illustrationeditvehicle,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.VEHICLES);
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
          path: AppVariable.vehiclepath,
          data: {
            "nomor_polisi": policeNumber.text,
            "tipe_kendaraan_id": carTypeModel.id,
            "keterangan": note.text,
            "nomor_pintu": doorNumber.text,
            "nomor_kir": kir.text,
            "nomor_stnk": stnk.text,
            "status": status.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Kendaraan Ditambahkan",
            subtitle: "Penambahan Kendaraan Selesai",
            detail:
                "Kendaraan berhasil ditambahkan. Silahkan lihat daftar kendaraan sekarang.",
            textBtn: "Lihat Kendaraan",
            path: AppIllustration.illustrationeditvehicle,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.VEHICLES);
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
