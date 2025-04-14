import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/input_select.dart';
import 'package:latransportindo/app/modules/add_schedule/controllers/add_schedule_controller.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

class FormScheduleView extends GetView<AddScheduleController> {
  const FormScheduleView({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int? index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddScheduleController>(builder: (context) {
      return Form(
        key: controller.formList[index!].keyController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pengemudi ${index! + 1}",
                  style: textRegular.copyWith(
                    fontSize: 16,
                    color: AppColor.blue600,
                  ),
                ),
                controller.isEdit || controller.formList.length < 2
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () => controller.removeForm(key: index),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColor.error50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            AppIcons.iconfillremove,
                            color: AppColor.error600,
                            width: 14,
                            height: 14,
                          ),
                        ),
                      )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Nama",
              style: textRegular.copyWith(
                fontSize: 12,
                color: AppColor.black400,
              ),
            ),
            const SizedBox(height: 4),
            InputSelect(
              controller: controller.formList[index!].driverController,
              onTap: () => Get.toNamed(Routes.SELECT_DRIVER)!.then((v) {
                if (v != null) {
                  controller.setDriver(key: index, value: v);
                }
              }),
              hintText: "Pilih pengemudi",
              validator: (v) => valString!(v, 'Pengemudi'),
            ),
            const SizedBox(height: 12),
            Text(
              "Kendaraan",
              style: textRegular.copyWith(
                fontSize: 12,
                color: AppColor.black400,
              ),
            ),
            const SizedBox(height: 4),
            InputSelect(
              controller: controller.formList[index!].vehicleController,
              onTap: () => Get.toNamed(Routes.SELECT_VEHICLE)!.then((v) {
                if (v != null) {
                  controller.setVehicle(key: index, value: v);
                  // controller.onChange();
                }
              }),
              hintText: "Pilih kendaraan",
              validator: (v) => valString!(v, 'Kendaraan'),
            ),
            const SizedBox(height: 12),
            Text(
              "Pelanggan",
              style: textRegular.copyWith(
                fontSize: 12,
                color: AppColor.black400,
              ),
            ),
            const SizedBox(height: 4),
            InputSelect(
              controller: controller.formList[index!].customerController,
              onTap: () => Get.toNamed(Routes.SELECT_CUSTOMER)!.then((v) {
                if (v != null) {
                  controller.setCustomer(key: index, value: v);
                  // controller.onChange();
                }
              }),
              hintText: "Pilih pelanggan",
              validator: (v) => valString!(v, 'Pelanggan'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lokasi ",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.addLocations(key: index),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColor.blue100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset(
                      AppIcons.iconfilladdlocation,
                      color: AppColor.blue800,
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...controller.formList[index!].formLocationsModel!
                .asMap()
                .entries
                .map((e) {
              var dataLength =
                  controller.formList[index!].formLocationsModel!.length;
              return Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (dataLength > 1) {
                            controller.removeLocation(
                              key: index,
                              keyIndex: e.key,
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: dataLength > 1
                                    ? AppColor.error600
                                    : AppColor.black300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: dataLength > 1
                                ? AppColor.error600
                                : AppColor.black300,
                            size: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputSelect(
                          controller: e.value.locationController,
                          onTap: () =>
                              Get.toNamed(Routes.SELECT_LOCATION)!.then((v) {
                            if (v != null) {
                              controller.setLocation(
                                key: index,
                                keyIndex: e.key,
                                value: v,
                              );
                              // controller.onChange();
                            }
                          }),
                          hintText: "Pilih lokasi",
                          validator: (v) => valString!(v, 'Lokasi'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              );
            })
          ],
        ),
      );
    });
  }
}
