import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleController extends GetxController {
  var isLoading = false;
  var isError = false;
  var isFilter = false;
  var isFirst = false;
  var error = "";
  var filter = DateFormat("yyyy-MM").format(DateTime.now());
  var page = 1;
  var list = <DateTime>[];
  var dateController = DateRangePickerController();
  var dateSelected = DateTime.now();
  var days = <String>['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    list = [];
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.schedulepath,
        queryParameters: {"date": filter},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        list = (result['data'] as List)
            .map<DateTime>((e) => DateTime.parse(e))
            .toList();
      } else {
        list = [];
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

  void onRefresh() {
    page = 1;
    isFilter = false;
    filter = DateFormat("yyyy-MM").format(DateTime.now());
    update();
    getData();
  }

  List<DateTime> distinctDateTimeList(List<DateTime> inputList) {
    return inputList.toSet().toList();
  }

  void swapMonth(DateTime? date) async {
    print(date);
    try {
      final response = await Api().getWithToken(
        path: AppVariable.schedulepath,
        queryParameters: {"date": DateFormat("yyyy-MM").format(date!)},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var resList = (result['data'] as List)
            .map<DateTime>((e) => DateTime.parse(e))
            .toList();
        list.addAll(resList);
        list = distinctDateTimeList(list);
        print(list);
        update();
      }
    } catch (_) {
      update();
    } finally {
      isFilter = true;
      update();
    }
  }

  void detailSchedule(date) {
    dateSelected = date ?? dateSelected;
    update();
    Get.toNamed(Routes.DETAIL_SCHEDULE, arguments: dateSelected)!
        .then((value) => onRefresh());
  }
}
