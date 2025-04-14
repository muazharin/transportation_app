import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/page_add_first.dart';
import 'package:latransportindo/app/modules/detail_schedule/views/list_data_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

import '../controllers/detail_schedule_controller.dart';

class DetailScheduleView extends GetView<DetailScheduleController> {
  const DetailScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Daftar Pengemudi'),
      body: GetBuilder<DetailScheduleController>(builder: (context) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError) {
          return ErrorPage(message: controller.error);
        } else if (controller.list.isEmpty) {
          return PageAddFirst(
            path: AppIllustration.illustrationnodata,
            title: "Jadwal",
            onTap: () => Get.toNamed(Routes.ADD_SCHEDULE,
                    arguments: {"date": DateTime.parse(controller.date)})!
                .then((value) => controller.getData()),
            detail:
                "Data jadwal tidak ditemukan. Silahkan tambahkan data jadwal sekarang.",
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async => controller.getData(),
            child: const ListDataView(),
          );
        }
      }),
    );
  }
}
