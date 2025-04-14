import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';

class PageAddFirst extends StatelessWidget {
  const PageAddFirst({
    super.key,
    this.path,
    this.detail,
    this.title,
    this.onTap,
  });
  final String? path;
  final String? detail;
  final String? title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          const SizedBox(height: 24),
          DottedBorder(
            color: AppColor.black200,
            radius: const Radius.circular(16),
            borderType: BorderType.RRect,
            dashPattern: const [12, 6],
            strokeWidth: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 44,
                horizontal: 56,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Image.asset(
                    path!,
                    width: 240,
                    height: 240,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    detail!,
                    textAlign: TextAlign.center,
                    style: textRegular.copyWith(
                      fontSize: 12,
                      color: AppColor.black500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ButtonDefault(
                    text: "Tambah $title",
                    radius: 32,
                    color: AppColor.yellow500,
                    onTap: onTap,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
