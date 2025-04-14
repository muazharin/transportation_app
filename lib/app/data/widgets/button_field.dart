import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class ButtonField extends StatelessWidget {
  const ButtonField({
    super.key,
    this.path,
    this.bgColor,
    this.txColor,
    this.text,
    this.onTap,
  });
  final String? path;
  final Color? bgColor;
  final Color? txColor;
  final String? text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(
            style: textRegular.copyWith(
              fontSize: 12,
              color: txColor,
            ),
            children: [
              WidgetSpan(
                child: Image.asset(
                  path!,
                  width: 18,
                  height: 18,
                  color: txColor,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: 4)),
              TextSpan(text: text!)
            ],
          ),
        ),
      ),
    );
  }
}
