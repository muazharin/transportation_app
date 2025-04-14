import 'dart:convert';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/models/history_user_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/utils/variables.dart';

class UserHistoryController extends GetxController {
  var isLoading = false;
  var isError = false;
  var error = "";
  var page = 1;
  var list = <HistoryUserModel>[];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void onRefresh() {
    page = 1;
    update();
    getData();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    list = [];
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.historyuserpath,
        queryParameters: {"page": page},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        list = result['data']
            .map<HistoryUserModel>((v) => HistoryUserModel.fromJson(v))
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

  void loadMore() async {
    try {
      final response = await Api().getWithToken(
        path: AppVariable.historyuserpath,
        queryParameters: {"page": page},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var newList = result['data']
            .map<HistoryUserModel>((v) => HistoryUserModel.fromJson(v))
            .toList();
        list.addAll(newList);
      }
      update();
    } catch (_) {}
  }
}
