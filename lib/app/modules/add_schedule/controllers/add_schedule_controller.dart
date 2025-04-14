import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/models/customer_model.dart';
import 'package:latransportindo/app/data/models/form_location_model.dart';
import 'package:latransportindo/app/data/models/form_schedule_model.dart';
import 'package:latransportindo/app/data/models/location_model.dart';
import 'package:latransportindo/app/data/models/schedule_model.dart';
import 'package:latransportindo/app/data/models/user_model.dart';
import 'package:latransportindo/app/data/models/vehicle_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/page_success.dart';
import 'package:latransportindo/app/data/widgets/snackbar_custom.dart';
import 'package:latransportindo/app/modules/add_schedule/views/confirm_schedule_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class AddScheduleController extends GetxController {
  var idController = TextEditingController();
  var jobDateController = TextEditingController();
  var jobDateFormat = DateTime.now();
  var formList = <FormScheduleModel>[];
  var key = GlobalKey<FormState>();
  var arg = Get.arguments['data'];
  var date = Get.arguments['date'];
  var isComplete = false;
  var isEdit = false;
  var title = "Isi Data Jadwal";
  var data = <ScheduleModel>[];
  var isLoading = false;

  @override
  void onInit() {
    if (arg != null) {
      isEdit = true;
      isComplete = true;
      title = "Ubah Data Jadwal";
      data = arg.toList();
      update();
      setFormEdit();
    } else {
      addForm();
      jobDateController.text = DateFormat("dd MMMM yyyy").format(date);
      jobDateFormat = date;
      update();
    }
    super.onInit();
  }

  void setFormEdit() {
    jobDateController.text =
        DateFormat("dd MMMM yyyy").format(data[0].tanggalTugas!);
    jobDateFormat = data[0].tanggalTugas!;

    for (var e in data) {
      formList.add(FormScheduleModel(
        keyController: GlobalKey<FormState>(),
        idController: TextEditingController(text: e.id),
        driverController: TextEditingController(text: e.nama!.nama),
        vehicleController:
            TextEditingController(text: e.vehicle!.nama!.toUpperCase()),
        customerController: TextEditingController(text: e.customer!.nama),
        formLocationsModel: [
          ...e.location!.map((ex) => FormLocationModel(
              locationController: TextEditingController(text: ex.nama),
              locationsModel: LocationModel(
                id: ex.idLocation,
                name: ex.nama,
              )))
        ],
        driverModel: UserModel(id: e.nama!.id, name: e.nama!.nama),
        vehicleModel:
            VehicleModel(id: e.vehicle!.id, policeNumber: e.vehicle!.nama),
        customerModel:
            CustomerModel(id: e.customer!.id, name: e.customer!.nama),
      ));
    }
  }

  void onChange() {
    isComplete = true;
    update();
  }

  void setJobDate(DateTime date) {
    jobDateController.text = DateFormat("dd MMMM yyyy").format(date);
    jobDateFormat = date;
    onChange();
  }

  void addForm() {
    formList.add(FormScheduleModel(
      keyController: GlobalKey<FormState>(),
      driverController: TextEditingController(),
      vehicleController: TextEditingController(),
      customerController: TextEditingController(),
      formLocationsModel: [
        FormLocationModel(
          locationController: TextEditingController(),
          locationsModel: LocationModel(),
        )
      ],
      driverModel: UserModel(),
      vehicleModel: VehicleModel(),
      customerModel: CustomerModel(),
    ));
    update();
  }

  void removeForm({int? key}) {
    formList.removeAt(key!);
    onChange();
  }

  void addLocations({int? key}) {
    formList[key!].formLocationsModel!.add(FormLocationModel(
        locationController: TextEditingController(),
        locationsModel: LocationModel()));
    onChange();
  }

  void setDriver({int? key, UserModel? value}) {
    formList[key!].driverController!.text = value!.name!;
    formList[key].driverModel = value;
    onChange();
  }

  void setVehicle({int? key, VehicleModel? value}) {
    formList[key!].vehicleController!.text = value!.policeNumber!.toUpperCase();
    formList[key].vehicleModel = value;
    onChange();
  }

  void setCustomer({int? key, CustomerModel? value}) {
    formList[key!].customerController!.text = value!.name!;
    formList[key].customerModel = value;
    onChange();
  }

  void setLocation({int? key, int? keyIndex, LocationModel? value}) {
    formList[key!].formLocationsModel![keyIndex!].locationController!.text =
        value!.name!;
    formList[key].formLocationsModel![keyIndex].locationsModel = value;
    onChange();
  }

  void removeLocation({int? key, int? keyIndex}) {
    formList[key!].formLocationsModel!.removeAt(keyIndex!);
    onChange();
  }

  bool formListValidator() {
    var isValid = true;
    for (var e in formList) {
      if (!e.keyController!.currentState!.validate()) {
        isValid = false;
        return isValid;
      }
    }
    return isValid;
  }

  void confirmSubmit() {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      if (formListValidator()) {
        if (isEdit) {
          handleSubmit();
        } else {
          Get.to(const ConfirmScheduleView());
        }
      }
    }
  }

  void handleSubmit() async {
    isLoading = true;
    update();
    loading(text: "Silahkan tunggu.\nData-data jadwal\nsedang diproses.");
    if (isEdit) {
      try {
        final response = await Api().putWithToken(
          path: AppVariable.schedulepath,
          data: {
            "tanggal_tugas": DateFormat("yyyy-MM-dd").format(jobDateFormat),
            "data_pengemudi": [
              ...formList.map(
                (e) => {
                  "id": e.idController!.text,
                  "nama_id": e.driverModel!.id,
                  "kendaraan_id": e.vehicleModel!.id,
                  "pelanggan_id": e.customerModel!.id,
                  "lokasi": [
                    ...e.formLocationsModel!
                        .map((ex) => {"location_id": ex.locationsModel!.id})
                  ]
                },
              )
            ],
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Jadwal Diubah",
            subtitle: "Perubahan Jadwal Selesai",
            detail:
                "Jadwal pengemudi sudah selesai diubah. Silahkan lihat jadwal sekarang.",
            textBtn: "Lihat Jadwal",
            path: AppIllustration.illustrationeditschedule,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.SCHEDULE);
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
          path: AppVariable.schedulepath,
          data: {
            "tanggal_tugas": DateFormat("yyyy-MM-dd").format(jobDateFormat),
            "data_pengemudi": [
              ...formList.map(
                (e) => {
                  "nama_id": e.driverModel!.id,
                  "kendaraan_id": e.vehicleModel!.id,
                  "pelanggan_id": e.customerModel!.id,
                  "lokasi": [
                    ...e.formLocationsModel!
                        .map((ex) => {"location_id": ex.locationsModel!.id})
                  ]
                },
              )
            ],
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.to(PageSuccess(
            title: "Jadwal Ditambahkan",
            subtitle: "Penambahan Jadwal Selesai",
            detail:
                "Jadwal berhasil ditambahkan. Silahkan lihat daftar jadwal sekarang.",
            textBtn: "Lihat Jadwal",
            path: AppIllustration.illustrationeditschedule,
            onTap: () {
              if (isAlternative) {
                isTroughtRoute = true;
                update();
                Get.until((route) => Get.currentRoute == Routes.ADMIN_HOME);
              } else {
                Get.until((route) => Get.currentRoute == Routes.SCHEDULE);
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
