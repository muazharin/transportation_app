import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/input_date.dart';
import 'package:latransportindo/app/modules/add_schedule/views/form_schedule_view.dart';

import '../controllers/add_schedule_controller.dart';

class AddScheduleView extends GetView<AddScheduleController> {
  const AddScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: controller.title),
      body: GetBuilder<AddScheduleController>(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.key,
            child: ListView(
              children: [
                Text(
                  "Tanggal Tugas",
                  style: textRegular.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                InputDate(
                  controller: controller.jobDateController,
                  hintText: "Pilih Tanggal",
                  onTap: (v) => controller.setJobDate(v!),
                  validator: (v) => valString!(v, "Pilih Tanggal"),
                ),
                !controller.isEdit
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColor.blue100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Data Pengemudi",
                                    style: textRegular.copyWith(fontSize: 12),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => controller.addForm(),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColor.blue500,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                          style: textSemiBold.copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              child: Image.asset(
                                                AppIcons.iconfilladd,
                                                width: 18,
                                                height: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const WidgetSpan(
                                                child: SizedBox(width: 4)),
                                            const TextSpan(
                                                text: "Tambah Pengemudi")
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                ...controller.formList.asMap().entries.map((e) {
                  return FormScheduleView(
                    index: e.key,
                  );
                }),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar:
          GetBuilder<AddScheduleController>(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ButtonDefault(
                text: controller.isEdit ? "Simpan" : "Selanjutnya",
                radius: 32,
                color: controller.isComplete
                    ? AppColor.yellow500
                    : AppColor.black200,
                // onTap: () {},
                onTap: controller.isComplete
                    ? () => !controller.isLoading
                        ? controller.confirmSubmit()
                        : () {}
                    : () {},
              ),
            ),
          ],
        );
      }),
    );
  }
}
