import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/field_confirm_data.dart';
import 'package:latransportindo/app/modules/detail_schedule/controllers/detail_schedule_controller.dart';

class ListDataView extends GetView<DetailScheduleController> {
  const ListDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailScheduleController>(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                InkWell(
                  onTap: () => controller.setAllChecked(),
                  child: Icon(
                    !controller.allChecked
                        ? Icons.check_box_outline_blank_rounded
                        : Icons.check_box_outlined,
                    color: AppColor.blue600,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.blue600,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppIcons.iconfillcalendar,
                          color: Colors.white,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Tanggal Tugas : ${DateFormat("dd MMMM yyyy").format(DateTime.parse(controller.date))}",
                            overflow: TextOverflow.ellipsis,
                            style: textBold.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        controller.listChecked > 0
                            ? Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Text(
                                    "(${controller.listChecked})",
                                    style: textBold.copyWith(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => controller.confirmDelete(),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColor.error50,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          AppIcons.iconfillremove,
                                          width: 16,
                                          height: 16,
                                          color: AppColor.error600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => controller.editSchedule(),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColor.success50,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          AppIcons.iconfilledit,
                                          width: 16,
                                          height: 16,
                                          color: AppColor.success600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...controller.list.asMap().entries.map(
                  (e) => Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: .1,
                          offset: const Offset(0, 2),
                          spreadRadius: .1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => controller.setCardChecked(e.key),
                              child: Icon(
                                !e.value.isChecked!
                                    ? Icons.check_box_outline_blank_rounded
                                    : Icons.check_box_outlined,
                                color: AppColor.blue600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              e.value.nama!.nama!,
                              style: textRegular,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        FieldConfirmData(
                          img: AppIcons.iconfillvehicle,
                          title: "Kendaraan",
                          value: e.value.vehicle!.nama!.toUpperCase(),
                        ),
                        const SizedBox(height: 8),
                        FieldConfirmData(
                          img: AppIcons.iconfillcustomer,
                          title: "Pelanggan",
                          value: e.value.customer!.nama,
                        ),
                        ...e.value.location!.asMap().entries.map(
                              (ex) => Column(
                                children: [
                                  const SizedBox(height: 8),
                                  FieldConfirmData(
                                    img: AppIcons.iconfilllocation,
                                    title: "Lokasi ${ex.key + 1}",
                                    value: ex.value.nama,
                                  ),
                                ],
                              ),
                            )
                      ],
                    ),
                  ),
                ),
          ],
        ),
      );
    });
  }
}
