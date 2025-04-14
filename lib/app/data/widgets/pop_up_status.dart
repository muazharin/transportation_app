import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/input_radio_button.dart';

class PopUpController extends GetxController {
  var status = "";
  void setStatus(String? v) {
    status = v!;
    update();
  }
}

class PopUpStatus extends StatelessWidget {
  const PopUpStatus({super.key, this.onTap});
  final void Function(String)? onTap;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopUpController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: () => Get.back(),
        child: GetBuilder<PopUpController>(builder: (_) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 56),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Status Pengiriman",
                      style: textSemiBold.copyWith(
                        fontSize: 16,
                        color: AppColor.yellow500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InputRadioButton(
                    isSelected: controller.status == "Loading",
                    value: "Loading",
                    title: "Loading",
                    onTap: () => controller.setStatus("Loading"),
                  ),
                  const SizedBox(height: 16),
                  InputRadioButton(
                    isSelected: controller.status == "Unloading",
                    value: "Unloading",
                    title: "Unloading",
                    onTap: () => controller.setStatus("Unloading"),
                  ),
                  const SizedBox(height: 24),
                  ButtonDefault(
                    radius: 32,
                    text: "Simpan",
                    color: controller.status.isEmpty
                        ? AppColor.black200
                        : AppColor.yellow500,
                    onTap: () {
                      if (controller.status.isNotEmpty) {
                        Get.back();
                        onTap!(controller.status);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
