import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class FieldConfirmData extends StatelessWidget {
  const FieldConfirmData({
    super.key,
    required this.img,
    required this.title,
    required this.value,
    this.isVisible = true,
  });
  final String? img;
  final String? title;
  final String? value;
  final bool? isVisible;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Image.asset(
                img!,
                width: 16,
                height: 16,
                color: AppColor.black400,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: textRegular.copyWith(
                    color: AppColor.black400,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          ":",
          style: textRegular.copyWith(
            color: AppColor.black400,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            "${isVisible! ? value : '••••••••••'}",
            style: textRegular.copyWith(
              color: AppColor.black400,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
