import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.minLines,
  });
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: textRegular,
      obscureText: isShow,
      onChanged: widget.onChanged,
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines ?? 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColor.black100,
        suffixIcon: InkWell(
          onTap: () => setState(() => isShow = !isShow),
          // child: isShow
          //     ? Image.asset('${Consts.iconPath}/eye_off.png')
          //     : Image.asset('${Consts.iconPath}/eye_on.png'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              // "${Consts.iconPath}/icon_outline_view.png",
              AppIcons.iconoutlineview,
              width: 24,
              height: 24,
              color: isShow ? AppColor.black100 : AppColor.black950,
            ),
          ),
        ),
        hintText: widget.hintText ?? '',
        hintStyle: textRegular.copyWith(color: AppColor.black400),
        errorMaxLines: 4,
        errorStyle: textRegular.copyWith(color: AppColor.error600),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.error600),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black100),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
