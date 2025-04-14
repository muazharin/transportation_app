import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/modules/detail_user_schedule/views/list_data_view.dart';

import '../controllers/detail_user_schedule_controller.dart';

class DetailUserScheduleView extends GetView<DetailUserScheduleController> {
  const DetailUserScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: "Detail Jadwal"),
      body: GetBuilder<DetailUserScheduleController>(builder: (context) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ErrorPage(message: controller.error),
          );
        }
        return const ListDataView();
      }),
    );
  }
}
