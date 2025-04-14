import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:latransportindo/app/data/models/location_model.dart';
import 'package:latransportindo/app/data/services/api.dart';
import 'package:latransportindo/app/data/utils/variables.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class LocationsController extends GetxController {
  var isLoading = false;
  var isError = false;
  var error = "";
  var page = 1;
  var isSearch = false;
  var isFilter = false;
  var list = <LocationModel>[];
  var searchController = TextEditingController();
  var statusController = TextEditingController();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));

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
    page = 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.locationpath,
        queryParameters: {
          "search": searchController.text,
          "status": statusController.text,
          "page": page,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        list = result['data']
            .map<LocationModel>((v) => LocationModel.fromJson(v))
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

  void onSearch({String? v}) {
    debouncer.call(() {
      isSearch = true;
      getData();
    });
  }

  void selectStatus({String? v}) {
    if (v == statusController.text) {
      statusController.text = "";
    } else {
      statusController.text = v!;
    }
    isSearch = true;
    update();
    getData();
  }

  void setFilter() {
    isFilter = !isFilter;
    update();
  }

  void loadMore() async {
    page = page + 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.locationpath,
        queryParameters: {
          "search": searchController.text,
          "status": statusController.text,
          "page": page,
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var newList = result['data']
            .map<LocationModel>((v) => LocationModel.fromJson(v))
            .toList();
        list.addAll(newList);
      }
      update();
    } catch (_) {}
  }

  void onRefresh() {
    isSearch = false;
    isFilter = false;
    statusController.text = "";
    searchController.text = "";
    update();
    getData();
  }

  void editLocation({LocationModel? data}) {
    Get.toNamed(
      Routes.ADD_LOCATION,
      arguments: data,
    )!
        .then((value) => onRefresh());
  }
}
