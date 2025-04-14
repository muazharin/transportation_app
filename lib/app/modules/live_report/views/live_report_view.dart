import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/modules/live_report/views/list_data_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../controllers/live_report_controller.dart';

class LiveReportView extends GetView<LiveReportController> {
  const LiveReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: 'Live Report'),
      body: GetBuilder<LiveReportController>(builder: (context) {
        if (controller.isLoading && !controller.isSearch) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError && !controller.isSearch) {
          return ErrorPage(message: controller.error);
        } else if (controller.list.isEmpty && !controller.isSearch) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 24),
                DottedBorder(
                  color: AppColor.black200,
                  radius: const Radius.circular(16),
                  borderType: BorderType.RRect,
                  dashPattern: const [12, 6],
                  strokeWidth: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 44,
                      horizontal: 56,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          AppIllustration.illustrationnodata,
                          width: 240,
                          height: 240,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Silahkan tunggu. Data live report belum tersedia.",
                          textAlign: TextAlign.center,
                          style: textRegular.copyWith(
                            fontSize: 12,
                            color: AppColor.black500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return LazyLoadScrollView(
          onEndOfPage: () => controller.loadMore(),
          child: RefreshIndicator(
            onRefresh: () async => controller.onRefresh(),
            child: const ListDataView(),
          ),
        );
      }),
    );
  }
}
