import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/input_password.dart';
import 'package:latransportindo/app/data/widgets/input_radio_button.dart';
import 'package:latransportindo/app/data/widgets/input_text.dart';

import '../controllers/add_user_controller.dart';

class AddUserView extends GetView<AddUserController> {
  const AddUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: controller.title),
      body: GetBuilder<AddUserController>(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.key,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Text(
                  "Data Pengguna",
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
                  controller: controller.nameController,
                  hintText: "Ketik nama pengguna disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valString!(v, 'Nama pengguna'),
                ),
                const SizedBox(height: 8),
                Text(
                  "No. Telepon",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  controller: controller.noTelpController,
                  hintText: "Ketik nomor telepon pengguna disini",
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valPhone!(v, 'Nomor telepon'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Password",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputPassword(
                  controller: controller.passwordController,
                  hintText: "Ketik password pengguna",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) {
                    if (controller.isEdit) {
                      if (controller.passwordController.text.isEmpty) {
                        return null;
                      }
                      return valPassword!(v, 'Password');
                    }
                    return valPassword!(v, 'Password');
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  "Tipe Pengguna",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  children: [
                    InputRadioButton(
                      isSelected: controller.userTypeController.text == "Admin",
                      title: "Admin",
                      onTap: () => controller.selectUserType(v: "Admin"),
                    ),
                    const SizedBox(width: 24),
                    InputRadioButton(
                      isSelected:
                          controller.userTypeController.text == "Pengemudi",
                      title: "Pengemudi",
                      onTap: () => controller.selectUserType(v: "Pengemudi"),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                controller.userTypeController.text == "Pengemudi"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nomor SIM",
                            style: textRegular.copyWith(
                              fontSize: 12,
                              color: AppColor.black400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InputText(
                            controller: controller.simNumberController,
                            hintText: "Ketik nomor SIM disini",
                            onChanged: (v) => controller.onChange(),
                            validator: (v) =>
                                valNumberLimit!(v, 'Nomor SIM', 14),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: GetBuilder<AddUserController>(builder: (context) {
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
