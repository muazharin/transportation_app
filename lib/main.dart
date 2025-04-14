import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';

void main() {
  initializeDateFormatting();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: AppColor.blue800),
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
