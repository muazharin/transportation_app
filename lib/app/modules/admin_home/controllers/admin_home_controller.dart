import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/models/schedule_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/data/widgets/pop_up_succes.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class AdminHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controllers = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late Animation<double> animation = CurvedAnimation(
    parent: controllers,
    curve: Curves.easeInOut,
  );
  var box = GetStorage();
  var isShowFloatMenu = false;
  var arg = Get.arguments;
  var selectedFloat = "";
  var list = <ScheduleModel>[];
  var date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void onInit() {
    getData();
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

  @override
  void onClose() {
    controllers.dispose();
    super.onClose();
  }

  void getData() async {
    try {
      final response = await Api().getWithToken(
        path: AppVariable.detailschedulepath,
        queryParameters: {"date": date},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        list = result['data']
            .map<ScheduleModel>((v) => ScheduleModel.fromJson(v))
            .toList();
      } else {
        list = [];
      }
      update();
    } catch (_) {}
  }

  void showFloatMenu() {
    isShowFloatMenu = !isShowFloatMenu;
    selectedFloat = "";
    update();
    toggleRotation();
  }

  void toggleRotation() {
    if (controllers.isCompleted) {
      controllers.reverse();
    } else {
      controllers.forward();
    }
    update();
  }

  void setSelectedFloat(
      {String? v, String? routes, String? routeMenu, dynamic arg}) {
    selectedFloat = v!;
    isTroughtRoute = false;
    isAlternative = true;
    update();
    Timer(const Duration(milliseconds: 270), () {
      Get.toNamed(routes!, arguments: arg)!.then((value) {
        showFloatMenu();
        getData();
        if (isTroughtRoute) {
          Get.toNamed(routeMenu!);
        }
      });
    });
  }

  void detailScheduleToday() {
    isTroughtRoute = false;
    isAlternative = true;
    update();
    Get.toNamed(Routes.DETAIL_SCHEDULE, arguments: DateTime.now())!.then(
      (_) {
        getData();
        if (isTroughtRoute) {
          Get.toNamed(Routes.SCHEDULE);
        }
      },
    );
  }

  void selectMenu({String? route}) {
    isAlternative = false;
    update();
    Get.toNamed(route!)!.then((value) => getData());
  }
}
