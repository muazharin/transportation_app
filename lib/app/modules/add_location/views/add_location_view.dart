import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/input_radio_button.dart';
import 'package:latransportindo/app/data/widgets/input_select.dart';
import 'package:latransportindo/app/data/widgets/input_text.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

import '../controllers/add_location_controller.dart';

class AddLocationView extends GetView<AddLocationController> {
  const AddLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: controller.title),
      body: GetBuilder<AddLocationController>(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.key,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Text(
                  "Data Lokasi",
                  style: textRegular.copyWith(fontSize: 12),
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
                InputText(
                  controller: controller.name,
                  hintText: "Ketik nama lokasi disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valString!(v, 'Nama lokasi'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Alamat",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  minLines: 1,
                  maxLines: 5,
                  controller: controller.address,
                  hintText: "Ketik alamat lokasi disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valString!(v, 'Alamat'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Pelanggan",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputSelect(
                  controller: controller.customer,
                  // onChanged: (v) => controller.onChange(),
                  onTap: () => Get.toNamed(Routes.SELECT_CUSTOMER)!.then((v) {
                    if (v != null) {
                      controller.setCustomer(v: v);
                      controller.onChange();
                    }
                  }),
                  hintText: "Pilih pelanggan",
                  validator: (v) => valString!(v, 'Jenis Pelanggan'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Status",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  children: [
                    InputRadioButton(
                      isSelected: controller.status.text == "Aktif",
                      title: "Aktif",
                      onTap: () => controller.selectStatus(v: "Aktif"),
                    ),
                    const SizedBox(width: 24),
                    InputRadioButton(
                      isSelected: controller.status.text == "Non-aktif",
                      title: "Non-aktif",
                      onTap: () => controller.selectStatus(v: "Non-aktif"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar:
          GetBuilder<AddLocationController>(builder: (context) {
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
