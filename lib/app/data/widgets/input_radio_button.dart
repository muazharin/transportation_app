import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class InputRadioButton extends StatelessWidget {
  const InputRadioButton({
    super.key,
    this.isSelected,
    this.value,
    this.title,
    this.onTap,
  });
  final bool? isSelected;
  final String? value;
  final String? title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isSelected! ? AppIcons.iconradiocheck : AppIcons.iconradiouncheck,
            color: isSelected! ? AppColor.black700 : AppColor.black400,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 8),
          Text(
            "$title",
            style: textRegular.copyWith(
              fontSize: 12,
              color: isSelected! ? AppColor.black700 : AppColor.black400,
            ),
          ),
        ],
      ),
    );
  }
}
