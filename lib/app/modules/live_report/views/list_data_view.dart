import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/widgets/empty_page.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/input_text.dart';
import 'package:latransportindo/app/modules/live_report/controllers/live_report_controller.dart';
import 'package:latransportindo/app/modules/live_report/views/card_list.dart';

class ListDataView extends GetView<LiveReportController> {
  const ListDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          InputText(
            controller: controller.searchController,
            borderRadius: 28,
            hintText: "Cari Pengemudi",
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                AppIcons.iconoutlinesearch,
                width: 24,
                height: 24,
                color: AppColor.black400,
              ),
            ),
            onChanged: (v) => controller.onSearch(v: v),
          ),
          const SizedBox(height: 16),
          Expanded(child: GetBuilder<LiveReportController>(builder: (context) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.isError) {
              return ErrorPage(message: controller.error);
            } else if (controller.list.isEmpty) {
              return const EmptyPage(
                message: "Data tidak ditemukan",
                type: "list",
              );
            }
            return ListView(
              children: [...controller.list.map((e) => CardList(data: e))],
            );
          })),
        ],
      ),
    );
  }
}
