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
import '../controllers/add_vehicle_controller.dart';

class AddVehicleView extends GetView<AddVehicleController> {
  const AddVehicleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: controller.title),
      body: GetBuilder<AddVehicleController>(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.key,
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Text(
                  "Data Kendaraan",
                  style: textRegular.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  "Nomor Polisi",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  controller: controller.policeNumber,
                  hintText: "Ketik nomor polisi disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valNumberTextOnly!(v, 'Nomor Polisi'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Jenis Mobil",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputSelect(
                  controller: controller.carType,
                  onTap: () => Get.toNamed(Routes.SELECT_CAR_TYPE)!.then((v) {
                    if (v != null) {
                      controller.setCarType(v: v);
                    }
                  }),
                  hintText: "Pilih jenis mobil",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valString!(v, 'Jenis Mobil'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Keterangan",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  minLines: 1,
                  maxLines: 5,
                  controller: controller.note,
                  hintText: "Ketik keterangan tambahan disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valString!(v, 'Keterangan'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Nomor Pintu",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  controller: controller.doorNumber,
                  hintText: "Ketik nomor pintu kendaraan disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valString!(v, 'Nomor Pintu'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Nomor KIR",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  controller: controller.kir,
                  hintText: "Ketik nomor KIR kendaraan disini",
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valNumberTextOnly!(v, 'Nomor KIR'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Nomor STNK",
                  style: textRegular.copyWith(
                    fontSize: 12,
                    color: AppColor.black400,
                  ),
                ),
                const SizedBox(height: 4),
                InputText(
                  controller: controller.stnk,
                  hintText: "Ketik nomor STNK kendaraan disini",
                  keyboardType: TextInputType.number,
                  onChanged: (v) => controller.onChange(),
                  validator: (v) => valNumberLimit!(v, 'Nomor STNK', 8),
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
      bottomNavigationBar: GetBuilder<AddVehicleController>(builder: (context) {
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
