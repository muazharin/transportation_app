import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

import 'package:latransportindo/app/data/utils/validators.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/input_password.dart';
import 'package:latransportindo/app/data/widgets/input_text.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue800,
      body: GetBuilder<SigninController>(builder: (context) {
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
                              child: Text("Masuk",
                                  style: textSemiBold.copyWith(fontSize: 24)),
                            ),
                          ),
                          Text(
                            "Silahkan masuk dengan mengisi data di bawah ini!",
                            style: textRegular,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Nomor Telepon",
                            style: textRegular.copyWith(
                              fontSize: 12,
                              color: AppColor.black400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InputText(
                            hintText: "Masukan nomor telepon disini",
                            keyboardType: TextInputType.phone,
                            controller: controller.phoneController,
                            onChanged: (v) => controller.onChange(),
                            validator: (v) => valPhone!(v, 'Nomor telepon'),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 12, 16),
                              child: Image.asset(
                                AppIcons.iconfillphone,
                                width: 24,
                                height: 24,
                                color: controller.phoneController.text.isEmpty
                                    ? AppColor.black100
                                    : AppColor.black400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Kata Sandi",
                            style: textRegular.copyWith(
                              fontSize: 12,
                              color: AppColor.black400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InputPassword(
                            hintText: "Masukan kata sandi disini",
                            controller: controller.passwordController,
                            onChanged: (v) => controller.onChange(),
                            validator: (v) => valPassword!(v, 'Kata sandi'),
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
                          const SizedBox(height: 64),
                          ButtonDefault(
                            color: AppColor.yellow500,
                            onTap: !controller.isLoading
                                ? () => controller.onSubmit()
                                : () {},
                            text: 'Masuk',
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
