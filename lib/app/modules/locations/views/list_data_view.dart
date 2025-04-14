import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/widgets/empty_page.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/input_checkbox.dart';

import 'package:latransportindo/app/data/widgets/input_text.dart';
import 'package:latransportindo/app/modules/locations/controllers/locations_controller.dart';
import 'package:latransportindo/app/modules/locations/views/card_list.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class ListDataView extends GetView<LocationsController> {
  const ListDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 24),
              GetBuilder<LocationsController>(builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: InputText(
                        controller: controller.searchController,
                        borderRadius: 28,
                        hintText: "Cari Lokasi",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            AppIcons.iconoutlinesearch,
                            width: 24,
                            height: 24,
                            color: AppColor.black400,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => controller.setFilter(),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(
                              AppIcons.iconfilledfilter,
                              width: 24,
                              height: 24,
                              color: AppColor.black400,
                            ),
                          ),
                        ),
                        onChanged: (v) => controller.onSearch(v: v),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.ADD_LOCATION)!
                          .then((value) => controller.onRefresh()),
                      child: CircleAvatar(
                        backgroundColor: AppColor.yellow500,
                        radius: 24,
                        child: Image.asset(
                          AppIcons.iconfilladdlocation,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              }),
              Expanded(
                child: GetBuilder<LocationsController>(builder: (context) {
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
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            ...controller.list.map<Widget>((e) {
                              return CardList(data: e);
                            }),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
          GetBuilder<LocationsController>(builder: (context) {
            if (!controller.isFilter) {
              return const SizedBox();
            }
            return Positioned(
              right: 64,
              child: Container(
                margin: const EdgeInsets.only(top: 88),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.black50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputCheckbox(
                      isSelected: controller.statusController.text == "Aktif",
                      title: "Aktif",
                      onTap: () => controller.selectStatus(v: "Aktif"),
                    ),
                    const SizedBox(height: 8),
                    InputCheckbox(
                      isSelected:
                          controller.statusController.text == "Non-aktif",
                      title: "Non Aktif",
                      onTap: () => controller.selectStatus(v: "Non-aktif"),
                    )
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
