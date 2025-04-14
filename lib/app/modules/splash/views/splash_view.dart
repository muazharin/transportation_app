import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue800,
      body: GetBuilder<SplashController>(builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                tag: "logo",
                child: Image.asset(
                  // AppIcons.truck,
                  "assets/icons/truck.png",
                  width: 64,
                  height: 64,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "LA Transportindo",
                style: textBold.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
