import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/button_outlined.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';
import 'package:latransportindo/app/data/widgets/field_confirm_data.dart';
import 'package:latransportindo/app/modules/add_schedule/controllers/add_schedule_controller.dart';

class ConfirmScheduleView extends GetView<AddScheduleController> {
  const ConfirmScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Konfirmasi Jadwal"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              Container(
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
                        "Tanggal Tugas : ${DateFormat("dd MMMM yyyy").format(controller.jobDateFormat)}",
                        style: textBold.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...controller.formList.map(
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
                      Text(
                        e.driverController!.text,
                        style: textRegular,
                      ),
                      const SizedBox(height: 12),
                      FieldConfirmData(
                        img: AppIcons.iconfillvehicle,
                        title: "Kendaraan",
                        value: e.vehicleController!.text.toUpperCase(),
                      ),
                      const SizedBox(height: 8),
                      FieldConfirmData(
                        img: AppIcons.iconfillcustomer,
                        title: "Pelanggan",
                        value: e.customerController!.text,
                      ),
                      ...e.formLocationsModel!.asMap().entries.map(
                            (ex) => Column(
                              children: [
                                const SizedBox(height: 8),
                                FieldConfirmData(
                                  img: AppIcons.iconfilllocation,
                                  title: "Lokasi ${ex.key + 1}",
                                  value: ex.value.locationController!.text,
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
        ),
      ),
      bottomNavigationBar:
          GetBuilder<AddScheduleController>(builder: (context) {
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
