import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class InputCheckbox extends StatelessWidget {
  const InputCheckbox({
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
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black600, width: 2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: isSelected!
                ? const Icon(
                    Icons.check,
                    size: 10,
                  )
                : const SizedBox(),
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
