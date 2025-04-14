import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/utils.dart';
import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/empty_page.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/input_text.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../controllers/select_vehicle_controller.dart';

class SelectVehicleView extends GetView<SelectVehicleController> {
  const SelectVehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: "Pilih Kendaraan"),
      body: LazyLoadScrollView(
        onEndOfPage: () => controller.loadMore(),
        child: RefreshIndicator(
          onRefresh: () async => controller.onRefresh(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                InputText(
                  hintText: "Cari Kendaraan",
                  controller: controller.searchController,
                  prefixIcon: const Icon(Icons.search),
                  validator: (v) => valString!(v, "Cari Kendaraan"),
                  onChanged: (v) => controller.onSearch(v: v),
                ),
                const SizedBox(height: 24),
                GetBuilder<SelectVehicleController>(builder: (context) {
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
                  return Expanded(
                    child: ListView(
                      children: [
                        ...controller.list.asMap().entries.map((e) {
                          return GestureDetector(
                            onTap: () => Get.back(result: e.value),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.black100),
                                borderRadius: borderRadiusGeometry(
                                  e.key,
                                  controller.list.length,
                                ),
                              ),
                              child: Text(
                                e.value.policeNumber!.toUpperCase(),
                                style: textRegular,
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
