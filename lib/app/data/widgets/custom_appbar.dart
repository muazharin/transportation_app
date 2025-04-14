import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

AppBar customAppBar({String? title, isEnableBack}) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColor.blue800,
    toolbarHeight: 88,
    centerTitle: true,
    automaticallyImplyLeading: isEnableBack ?? true,
    title: Text(
      "$title",
      style: textSemiBold.copyWith(color: Colors.white, fontSize: 20),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(32),
      ),
    ),
  );
}
