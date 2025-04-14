import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';

import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/page_add_first.dart';
import 'package:latransportindo/app/modules/customers/views/list_data_view.dart';
import 'package:latransportindo/app/routes/app_pages.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../controllers/customers_controller.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: 'Pelanggan'),
      body: GetBuilder<CustomersController>(builder: (context) {
        if (controller.isLoading && !controller.isSearch) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError && !controller.isSearch) {
          return ErrorPage(message: controller.error);
        } else if (controller.list.isEmpty && !controller.isSearch) {
          return PageAddFirst(
            path: AppIllustration.illustrationnodata,
            title: "Pelanggan",
            onTap: () => Get.toNamed(Routes.ADD_CUSTOMER)!
                .then((value) => controller.onRefresh()),
            detail:
                "Data pelanggan tidak ditemukan. Silahkan tambahkan data pelanggan sekarang.",
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
