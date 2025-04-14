import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/models/month_model.dart';
import 'package:latransportindo/app/data/models/my_schedule_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class UserScheduleController extends GetxController {
  var isLoading = false;
  var isError = false;
  var error = "";
  var list = <MyScheduleModel>[];
  var listDate = <DateTime>[];
  var month = MonthModel(
    name: DateFormat("MMMM", "id_ID").format(DateTime.now()),
    no: DateFormat("MM", "id_ID").format(DateTime.now()),
  );
  var year = int.parse(DateFormat("yyyy", "id_ID").format(DateTime.now()));
  var days = <DateTime>[];
  var date = DateTime.now();
  var listController = PageController();
  var currentPage = 0;

  @override
  void onInit() {
    date = DateTime(date.year, date.month, date.day, 0, 0, 0);
    getDays();
    getData();
    super.onInit();
  }

  @override
  void onClose() {
    listController.dispose();
    super.onClose();
  }

  void setMonth(MonthModel? v) {
    Get.back();
    month = v!;
    update();
    getDays();
  }

  void setYear(int? v) {
    Get.back();
    year = v!;
    update();
    getDays();
  }

  void getDays() {
    days = getAllDatesInMonth(year, int.parse(month.no!));
    update();
    autoSwap();
  }

  void selectDate(DateTime? v) {
    date = v!;
    update();
    getData();
  }

  void autoSwap() {
    var now = DateTime.now();
    now = DateTime(now.year, now.month, now.day, 0, 0, 0);
    var i = int.parse(DateFormat("dd").format(now));
    var j = Get.width ~/ 59;
    if (i == 23 || i == 29) {
      currentPage = (i / j).ceil();
    } else {
      currentPage = i ~/ j;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (days.contains(now)) {
        selectDate(now);
        listController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        update();
      } else {
        selectDate(DateTime.parse("$year-${month.no}-01"));
        listController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        update();
      }
    });
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    list = [];
    update();

    List<Future<Response>> listResponses = [
      Api().getWithToken(
        path: AppVariable.scheduleuserpath,
        queryParameters: {"date": DateFormat("yyyy-MM-dd").format(date)},
      ),
      Api().getWithToken(
        path: AppVariable.listdateschedulepath,
        queryParameters: {"date": "$year-${month.no}"},
      ),
    ];
    try {
      List<Response> responses = await Future.wait(listResponses);
      for (var i = 0; i < responses.length; i++) {
        var result = jsonDecode(responses[i].toString());
        if (result['status']) {
          if (i == 0) {
            list = result['data']
                .map<MyScheduleModel>((v) => MyScheduleModel.fromJson(v))
                .toList();
          } else {
            listDate = (result['data'] as List)
                .map<DateTime>((e) => DateTime.parse(e))
                .toList();
          }
        } else {
          if (i == 0) {
            list = [];
          }
        }
      }
      isLoading = false;
      update();
    } catch (e) {
      isError = true;
      error = e.toString();
      isLoading = false;
      update();
    }
  }

  void pickschedule(MyScheduleModel? v) {
    Get.toNamed(Routes.DETAIL_USER_SCHEDULE, arguments: v)!
        .then((_) => getData());
  }

  Color getBgColor(String? status) {
    if (status == "Belum Diproses") {
      return AppColor.error100;
    } else if (status == "Diproses") {
      return AppColor.yellow100;
    }
    return AppColor.success100;
  }

  Color getTxColor(String? status) {
    if (status == "Belum Diproses") {
      return AppColor.error600;
    } else if (status == "Diproses") {
      return AppColor.yellow600;
    }
    return AppColor.success600;
  }

  Color getBgDateColor(DateTime? d) {
    if (date == d) {
      return AppColor.yellow500;
    }
    return AppColor.blue800;
  }

  Color getTxDateColor(DateTime? d) {
    if (date == d) {
      return Colors.white;
    } else if (listDate.contains(d)) {
      return AppColor.yellow600;
    }
    return Colors.white;
  }
}
