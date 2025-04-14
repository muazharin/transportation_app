import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';

class PopUpSuccess extends StatelessWidget {
  const PopUpSuccess({
    super.key,
    this.title,
    this.btnText,
    this.detail,
    this.onTap,
    this.isShowIcons = false,
    this.isShowButton = true,
  });
  final String? title;
  final String? detail;
  final String? btnText;
  final bool? isShowIcons;
  final bool? isShowButton;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: isShowButton! ? () {} : () => Get.back(),
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
                isShowIcons!
                    ? Image.asset(
                        AppIcons.iconoutlinesuccess,
                        width: 64,
                        height: 64,
                        color: AppColor.success600,
                      )
                    : const SizedBox(),
                const SizedBox(height: 16),
                Text(
                  "$title",
                  style: textSemiBold.copyWith(
                    fontSize: 16,
                    color: AppColor.success600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "$detail",
                  textAlign: TextAlign.center,
                  style: textRegular.copyWith(color: AppColor.black400),
                ),
                const SizedBox(height: 24),
                isShowButton!
                    ? Row(
                        children: [
                          const Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: ButtonDefault(
                              text: btnText ?? "Lanjutkan",
                              textSize: 12,
                              radius: 8,
                              color: AppColor.success600,
                              onTap: onTap,
                            ),
                          ),
                          const Expanded(flex: 2, child: SizedBox()),
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
