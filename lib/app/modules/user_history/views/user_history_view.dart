import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';

import '../controllers/user_history_controller.dart';
import 'card_list.dart';

class UserHistoryView extends GetView<UserHistoryController> {
  const UserHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: "Riwayat"),
      body: GetBuilder<UserHistoryController>(builder: (context) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError) {
          return ErrorPage(message: controller.error);
        } else if (controller.list.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppIllustration.illustrationnodata,
                  width: 240,
                  height: 240,
                ),
                const SizedBox(height: 16),
                Text(
                  "Silahkan tunggu.\nData riwayat belum tersedia.",
                  textAlign: TextAlign.center,
                  style: textRegular.copyWith(
                    fontSize: 16,
                    color: AppColor.black500,
                  ),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => controller.onRefresh(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 24),
                ...controller.list.map((e) => CardList(data: e))
              ],
            ),
          ),
        );
      }),
    );
  }
}
