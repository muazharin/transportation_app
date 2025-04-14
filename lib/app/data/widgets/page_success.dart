import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';

class PageSuccess extends StatelessWidget {
  const PageSuccess({
    super.key,
    this.title,
    this.path,
    this.subtitle,
    this.detail,
    this.textBtn,
    this.colorBtn,
    this.onTap,
  });
  final String? title;
  final String? subtitle;
  final String? detail;
  final String? path;
  final String? textBtn;
  final Color? colorBtn;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: customAppBar(title: title!, isEnableBack: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                path!,
                height: 343,
                width: 343,
              ),
              const SizedBox(height: 32),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: textBold.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Text(
                detail!,
                textAlign: TextAlign.center,
                style: textRegular.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 32),
              ButtonDefault(
                text: textBtn,
                color: colorBtn ?? AppColor.yellow500,
                onTap: onTap,
                radius: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
