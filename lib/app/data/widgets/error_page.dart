import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/utils/variables.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.message});
  final String? message;
  @override
  Widget build(BuildContext context) {
    var image = AppIllustration.illustrationerror;
    if (message == AppVariable.noInternet) {
      image = AppIllustration.illustrationconnectionissue;
    } else if (message == AppVariable.notfound) {
      image = AppIllustration.illustration404;
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            width: 240,
            height: 240,
          ),
          const SizedBox(height: 8),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: textRegular.copyWith(color: AppColor.black400),
          ),
        ],
      ),
    );
  }
}
