import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/input_radio_button.dart';
import 'package:latransportindo/app/data/widgets/input_text.dart';
import '../controllers/add_customer_controller.dart';

class AddCustomerView extends GetView<AddCustomerController> {
  const AddCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: controller.title),
      body: GetBuilder<AddCustomerController>(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.key,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Text(
                  "Data Pelanggan",
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
                  hintText: "Ketik nama pelanggan disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valString!(v, 'Nama pelanggan'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Nomor Telepon",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  controller: controller.noTelp,
                  hintText: "Ketik nomor telepon pelanggan disini",
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valPhone!(v, 'Nomor telepon'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Email",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  controller: controller.email,
                  hintText: "Ketik email pengguna disini",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valEmail!(v, 'Email'),
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
          GetBuilder<AddCustomerController>(builder: (context) {
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
