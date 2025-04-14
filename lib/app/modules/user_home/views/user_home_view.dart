import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/modules/user_history/views/user_history_view.dart';
import 'package:latransportindo/app/modules/user_schedule/views/user_schedule_view.dart';

import '../controllers/user_home_controller.dart';

class UserHomeView extends GetView<UserHomeController> {
  const UserHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget bottomMenu(String? title, String? icon, int? index) {
      return GestureDetector(
        onTap: () => controller.setIndex(index),
        child: SizedBox(
          // width: 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: controller.index == index
                      ? AppColor.blue100
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  icon!,
                  width: 24,
                  height: 24,
                  color: controller.index == index
                      ? AppColor.blue700
                      : AppColor.black400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title!,
                style: textBold.copyWith(
                  fontSize: 12,
                  color: controller.index == index
                      ? AppColor.blue700
                      : AppColor.black400,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: GetBuilder<UserHomeController>(builder: (context) {
        return IndexedStack(
          index: controller.index,
          children: const [
            UserScheduleView(),
            UserHistoryView(),
          ],
        );
      }),
      bottomNavigationBar: GetBuilder<UserHomeController>(builder: (context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                color: AppColor.black100,
                height: 0,
                indent: 0,
                thickness: 1,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  bottomMenu("Beranda", AppIcons.iconfillhome, 0),
                  bottomMenu("Riwayat", AppIcons.iconfillhistory, 1),
                  bottomMenu("Profil", AppIcons.iconoutlineperson, 2),
                  // SizedBox(
                  //   width: 120,
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //           vertical: 4,
                  //           horizontal: 20,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           color: AppColor.blue100,
                  //           borderRadius: BorderRadius.circular(16),
                  //         ),
                  //         child: Image.asset(
                  //           AppIcons.iconfillhome,
                  //           width: 24,
                  //           height: 24,
                  //           color: AppColor.blue700,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 4),
                  //       Text(
                  //         "Beranda",
                  //         style: textBold.copyWith(
                  //             fontSize: 12, color: AppColor.blue700),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}
