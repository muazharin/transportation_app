import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/button_outlined.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/field_confirm_data.dart';
import 'package:latransportindo/app/modules/add_vehicle/controllers/add_vehicle_controller.dart';

class ConfirmVehicleView extends GetView<AddVehicleController> {
  const ConfirmVehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Konfirmasi Kendaraan"),
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
                      "Data Kendaraan",
                      style: textRegular,
                    ),
                    const SizedBox(height: 12),
                    FieldConfirmData(
                      img: AppIcons.iconfillcard,
                      title: "Nomor Polisi",
                      value: controller.policeNumber.text,
                    ),
                    FieldConfirmData(
                      img: AppIcons.iconfillvehicle,
                      title: "Jenis Mobil",
                      value: controller.carType.text.toUpperCase(),
                    ),
                    FieldConfirmData(
                      img: AppIcons.iconfillnotes,
                      title: "Keterangan",
                      value: controller.note.text,
                    ),
                    FieldConfirmData(
                      img: AppIcons.iconfilldoor,
                      title: "Nomor Pintu",
                      value: controller.doorNumber.text,
                    ),
                    FieldConfirmData(
                      img: AppIcons.iconfillcard,
                      title: "Nomor KIR",
                      value: controller.kir.text,
                    ),
                    FieldConfirmData(
                      img: AppIcons.iconfillcard,
                      title: "Nomor STNK",
                      value: controller.stnk.text,
                    ),
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
      bottomNavigationBar: GetBuilder<AddVehicleController>(builder: (context) {
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
