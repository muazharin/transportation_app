import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class FloatMenu extends StatelessWidget {
  const FloatMenu({
    super.key,
    this.isSelected,
    this.path,
    this.title,
    this.onTap,
  });
  final bool? isSelected;
  final String? path;
  final String? title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isSelected! ? AppColor.blue100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                "$path",
                color: isSelected! ? AppColor.blue600 : AppColor.black400,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "$title",
              style: textSemiBold.copyWith(
                color: isSelected! ? AppColor.blue600 : AppColor.black400,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
