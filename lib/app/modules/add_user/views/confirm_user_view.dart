import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/button_outlined.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/field_confirm_data.dart';
import 'package:latransportindo/app/modules/add_user/controllers/add_user_controller.dart';

class ConfirmUserView extends GetView<AddUserController> {
  const ConfirmUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Konfirmasi Pengguna"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF101010).withOpacity(.25),
                      blurStyle: BlurStyle.outer,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Data Pengguna",
                      style: textSemiBold,
                    ),
                    const SizedBox(height: 12),
                    FieldConfirmData(
                      title: "Nama",
                      img: AppIcons.iconfillname,
                      value: controller.nameController.text,
                    ),
                    const SizedBox(height: 8),
                    FieldConfirmData(
                      title: "No. Telepon",
                      img: AppIcons.iconfillphone,
                      value: controller.noTelpController.text,
                    ),
                    const SizedBox(height: 8),
                    FieldConfirmData(
                      title: "Password",
                      img: AppIcons.iconfilllock,
                      value: controller.passwordController.text,
                      isVisible: false,
                    ),
                    const SizedBox(height: 8),
                    FieldConfirmData(
                      title: "Tipe Pengguna",
                      img: AppIcons.iconfilluser,
                      value: controller.userTypeController.text,
                    ),
                    const SizedBox(height: 8),
                    controller.userTypeController.text == "Pengemudi"
                        ? FieldConfirmData(
                            title: "Nomor SIM",
                            img: AppIcons.iconfillcard,
                            value: controller.simNumberController.text,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<AddUserController>(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonOutlined(
                text: 'Ubah Data',
                radius: 32,
                onTap: () => Get.back(),
                borderColor: AppColor.yellow500,
              ),
              const SizedBox(height: 12),
              ButtonDefault(
                text: controller.isEdit ? "Simpan" : "Tambah Sekarang",
                radius: 32,
                color: AppColor.yellow500,
                onTap: () => controller.handleSubmit(),
              )
            ],
          ),
        );
      }),
    );
  }
}
