import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/widgets/empty_page.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/input_checkbox.dart';

import 'package:latransportindo/app/data/widgets/input_text.dart';
import 'package:latransportindo/app/modules/users/controllers/users_controller.dart';
import 'package:latransportindo/app/modules/users/views/card_list.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class ListDataView extends GetView<UsersController> {
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
              GetBuilder<UsersController>(builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: InputText(
                        controller: controller.searchController,
                        borderRadius: 28,
                        hintText: "Cari Pengguna",
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
                      onTap: () => Get.toNamed(Routes.ADD_USER)!
                          .then((value) => controller.onRefresh()),
                      child: CircleAvatar(
                        backgroundColor: AppColor.yellow500,
                        radius: 24,
                        child: Image.asset(
                          AppIcons.iconfilladduser,
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
                child: GetBuilder<UsersController>(builder: (context) {
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
                            const SizedBox(height: 24),
                          ],
                        ),
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
          GetBuilder<UsersController>(builder: (context) {
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
                      isSelected: controller.userType.text == "Admin",
                      title: "Admin",
                      onTap: () => controller.selectUserType(v: "Admin"),
                    ),
                    const SizedBox(height: 8),
                    InputCheckbox(
                      isSelected: controller.userType.text == "Pengemudi",
                      title: "Pengemudi",
                      onTap: () => controller.selectUserType(v: "Pengemudi"),
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
