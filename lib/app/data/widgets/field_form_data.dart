import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class FieldFormData extends StatelessWidget {
  const FieldFormData(
      {super.key, this.title, this.value, this.widget, this.isShow});
  final String? title;
  final String? value;
  final Widget? widget;
  final bool? isShow;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            title!,
            style: textSemiBold.copyWith(fontSize: 12),
          ),
        ),
        Expanded(
          flex: 6,
          child: widget ??
              Text(
                value!,
                overflow: isShow! ? TextOverflow.clip : TextOverflow.ellipsis,
                style: textRegular.copyWith(
                    fontSize: 12, color: AppColor.black400),
              ),
        ),
      ],
    );
  }
}
