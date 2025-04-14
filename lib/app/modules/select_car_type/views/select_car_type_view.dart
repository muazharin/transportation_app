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
import 'package:latransportindo/app/modules/select_car_type/controllers/select_car_type_controller.dart';

class SelectCarTypeView extends GetView<SelectCarTypeController> {
  const SelectCarTypeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: "Pilih Jenis Mobil"),
      body: LazyLoadScrollView(
        onEndOfPage: () => controller.loadMore(),
        child: RefreshIndicator(
          onRefresh: () async => controller.onRefresh(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                InputText(
                  controller: controller.searchController,
                  hintText: "Cari Jenis Mobil",
                  prefixIcon: const Icon(Icons.search),
                  validator: (v) => valString!(v, "Cari Jenis Mobil"),
                  onChanged: (v) => controller.onSearch(v: v),
                ),
                const SizedBox(height: 24),
                GetBuilder<SelectCarTypeController>(builder: (context) {
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
                                e.value.name!,
                                style: textRegular,
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
