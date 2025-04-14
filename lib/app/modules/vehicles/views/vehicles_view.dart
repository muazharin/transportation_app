import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';

import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/page_add_first.dart';
import 'package:latransportindo/app/modules/vehicles/views/list_data_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../controllers/vehicles_controller.dart';

class VehiclesView extends GetView<VehiclesController> {
  const VehiclesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: 'Kendaraan'),
      body: GetBuilder<VehiclesController>(builder: (context) {
        if (controller.isLoading && !controller.isSearch) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError && !controller.isSearch) {
          return ErrorPage(message: controller.error);
        } else if (controller.list.isEmpty && !controller.isSearch) {
          return PageAddFirst(
            path: AppIllustration.illustrationnodata,
            title: "Kendaraan",
            onTap: () => Get.toNamed(Routes.ADD_VEHICLE)!
                .then((value) => controller.onRefresh()),
            detail:
                "Data kendaraan tidak ditemukan. Silahkan tambahkan data kendaraan sekarang.",
          );
        } else {
          return LazyLoadScrollView(
            onEndOfPage: () => controller.loadMore(),
            child: RefreshIndicator(
              onRefresh: () async => controller.onRefresh(),
              child: const ListDataView(),
            ),
          );
        }
      }),
    );
  }
}
