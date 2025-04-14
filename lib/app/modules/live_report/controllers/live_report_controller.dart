import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:latransportindo/app/data/models/history_user_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/utils/variables.dart';

class LiveReportController extends GetxController {
  var isLoading = false;
  var isError = false;
  var isSearch = false;
  var error = "";
  var page = 1;
  var list = <HistoryUserModel>[];
  var searchController = TextEditingController();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void onSearch({String? v}) {
    debouncer.call(() {
      isSearch = true;
      getData();
    });
  }

  void onRefresh() {
    isSearch = false;
    searchController.text = "";
    update();
    getData();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    list = [];
    page = 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.historyadminpath,
        queryParameters: {
          "search": searchController.text,
          "page": page,
        },
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
    page = page + 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.historyadminpath,
        queryParameters: {
          "search": searchController.text,
          "page": page,
        },
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
