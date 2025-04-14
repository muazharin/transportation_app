import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class InputSelect extends StatelessWidget {
  const InputSelect({
    super.key,
    this.controller,
    this.onTap,
    this.validator,
    this.onChanged,
    this.hintText,
    this.borderRadius = 12,
  });
  final TextEditingController? controller;
  final void Function()? onTap;
  final double? borderRadius;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textRegular,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: true,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColor.black400,
        ),
        hintText: hintText ?? '',
        hintStyle: textRegular.copyWith(color: AppColor.black400),
        errorMaxLines: 4,
        errorStyle: textRegular.copyWith(color: AppColor.error600),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.error600),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black100),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
      ),
    );
  }
}
