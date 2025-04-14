import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/page_add_first.dart';
import 'package:latransportindo/app/modules/schedule/views/list_data_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

import '../controllers/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: 'Jadwal'),
      body: GetBuilder<ScheduleController>(builder: (context) {
        if (controller.isLoading && !controller.isFilter) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError && !controller.isFilter) {
          return ErrorPage(message: controller.error);
        } else if (controller.list.isEmpty && !controller.isFilter) {
          return PageAddFirst(
            path: AppIllustration.illustrationnodata,
            title: "Jadwal",
            onTap: () => Get.toNamed(Routes.ADD_SCHEDULE,
                    arguments: {"date": DateTime.now()})!
                .then((value) => controller.onRefresh()),
            detail:
                "Data jadwal tidak ditemukan. Silahkan tambahkan data jadwal sekarang.",
          );
        } else {
          return const ListDataView();
        }
      }),
    );
  }
}
