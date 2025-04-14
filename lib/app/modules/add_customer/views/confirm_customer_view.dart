import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/button_outlined.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/field_confirm_data.dart';
import 'package:latransportindo/app/modules/add_customer/controllers/add_customer_controller.dart';

class ConfirmCustomerView extends GetView<AddCustomerController> {
  const ConfirmCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Konfirmasi Pelanggan"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
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
                    Text(
                      "Data Pelanggan",
                      style: textRegular,
                    ),
                    const SizedBox(height: 12),
                    FieldConfirmData(
                      img: AppIcons.iconfillname,
                      title: "Nama",
                      value: controller.name.text,
                    ),
                    const SizedBox(height: 8),
                    FieldConfirmData(
                      img: AppIcons.iconfillphone,
                      title: "Nomor Telepon",
                      value: controller.noTelp.text,
                    ),
                    const SizedBox(height: 8),
                    FieldConfirmData(
                      img: AppIcons.iconfillemail,
                      title: "Email",
                      value: controller.email.text,
                    ),
                    const SizedBox(height: 8),
                    FieldConfirmData(
                      img: AppIcons.iconfillstatus,
                      title: "Status",
                      value: controller.status.text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          GetBuilder<AddCustomerController>(builder: (context) {
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
                text: "Tambah Sekarang",
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
