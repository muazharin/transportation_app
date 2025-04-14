import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

BorderRadiusGeometry borderRadiusGeometry(int key, int length) {
  if (key == 0 && key == (length - 1)) {
    return BorderRadius.circular(16);
  } else if (key == 0) {
    return const BorderRadius.vertical(top: Radius.circular(16));
  } else if (key == length - 1) {
    return const BorderRadius.vertical(bottom: Radius.circular(16));
  } else {
    return BorderRadius.circular(0);
  }
}

void loading({String? text}) {
  Get.generalDialog(
    pageBuilder: (context, i, j) => WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: Get.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                text!,
                textAlign: TextAlign.center,
                style: textRegular.copyWith(
                  fontSize: 16,
                  color: AppColor.black400,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

List<DateTime> getAllDatesInMonth(int year, int month) {
  List<DateTime> dates = [];
  if (month < 1 || month > 12) {
    throw ArgumentError(
        'Invalid month: $month. Month must be between 1 and 12.');
  }
  int daysInMonth = DateTime(year, month + 1, 0).day;
  for (int day = 1; day <= daysInMonth; day++) {
    dates.add(DateTime(year, month, day));
  }

  return dates;
}

Color statusTextColor({String? status}) {
  if (status!.toLowerCase() == "aktif") return AppColor.blue400;
  return AppColor.yellow500;
}

Color statusBgColor({String? status}) {
  if (status!.toLowerCase() == "aktif") return AppColor.blue100;
  return AppColor.yellow100;
}
