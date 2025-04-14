import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/button_outlined.dart';

class PopUpDelete extends StatelessWidget {
  const PopUpDelete({
    super.key,
    this.title,
    this.detail,
    this.onTap,
    this.isShowButton = true,
    this.isShowIcon = false,
  });
  final String? title;
  final String? detail;
  final bool? isShowButton;
  final bool? isShowIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: () => Get.back(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 56),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isShowIcon!
                    ? Image.asset(
                        AppIcons.iconfillclose,
                        width: 64,
                        height: 64,
                        color: AppColor.error600,
                      )
                    : const SizedBox(),
                Text(
                  "$title",
                  style: textSemiBold.copyWith(
                    fontSize: 16,
                    color: AppColor.error600,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "$detail",
                  textAlign: TextAlign.center,
                  style: textRegular.copyWith(color: AppColor.black400),
                ),
                const SizedBox(height: 24),
                isShowButton!
                    ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ButtonOutlined(
                              text: "Tidak",
                              textSize: 12,
                              radius: 8,
                              onTap: () => Get.back(),
                              borderColor: AppColor.black200,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ButtonDefault(
                              text: "Ya, hapus sekarang",
                              textSize: 12,
                              radius: 8,
                              color: AppColor.error600,
                              onTap: onTap,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
