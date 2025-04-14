import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({
    super.key,
    this.title,
    this.titleColor,
    this.path,
    this.onTap,
    this.bgColor,
    this.iconColor,
  });

  final String? title;
  final Color? titleColor;
  final String? path;
  final void Function()? onTap;
  final bool? isFlip = false;
  final Color? bgColor;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "$path",
              width: 24,
              height: 24,
              color: iconColor ?? AppColor.blue600,
            ),
            const SizedBox(height: 8),
            Text(
              title!,
              textAlign: TextAlign.center,
              style: textRegular.copyWith(
                  color: titleColor ?? AppColor.blue600, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
