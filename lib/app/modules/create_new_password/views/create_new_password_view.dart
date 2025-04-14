import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/input_password.dart';

import '../controllers/create_new_password_controller.dart';

class CreateNewPasswordView extends GetView<CreateNewPasswordController> {
  const CreateNewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue800,
      body: GetBuilder<CreateNewPasswordController>(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  Hero(
                    tag: "logo",
                    child: Image.asset(
                      AppIcons.truck,
                      width: 64,
                      height: 64,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    "LA Transportindo",
                    textAlign: TextAlign.center,
                    style: textBold.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Form(
                      key: controller.key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Text(
                                "Buat Kata Sandi",
                                style: textSemiBold.copyWith(fontSize: 24),
                              ),
                            ),
                          ),
                          Text(
                            "Silahkan isi data di bawah ini untuk perbaruan kata sandi anda!",
                            style: textRegular,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Kata Sandi Baru",
                            style: textRegular.copyWith(
                              fontSize: 12,
                              color: AppColor.black400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InputPassword(
                            hintText: "Masukan kata sandi baru disini",
                            controller: controller.passwordController,
                            onChanged: (v) => controller.update(),
                            validator: (v) => valPassword!(v, 'Kata Sandi'),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 12, 16),
                              child: Image.asset(
                                AppIcons.iconfilllock,
                                width: 24,
                                height: 24,
                                color:
                                    controller.passwordController.text.isEmpty
                                        ? AppColor.black100
                                        : AppColor.black400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Konfirmasi Kata Sandi",
                            style: textRegular.copyWith(
                              fontSize: 12,
                              color: AppColor.black400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InputPassword(
                            hintText: "Masukan konfirmasi kata sandi",
                            controller: controller.confirmPasswordController,
                            onChanged: (v) => controller.update(),
                            validator: (v) => valCPassword!(
                                v,
                                'Konfirmasi kata sandi',
                                controller.passwordController.text),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 12, 16),
                              child: Image.asset(
                                AppIcons.iconfilllock,
                                width: 24,
                                height: 24,
                                color: controller
                                        .confirmPasswordController.text.isEmpty
                                    ? AppColor.black100
                                    : AppColor.black400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 64),
                          ButtonDefault(
                            color: AppColor.yellow500,
                            onTap: !controller.isLoading
                                ? () => controller.onSubmit()
                                : () {},
                            text: 'Simpan',
                            radius: 32,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
