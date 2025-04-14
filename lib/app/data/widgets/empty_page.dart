import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    super.key,
    required this.message,
    this.type = "page",
  });
  final String? message;
  final String? type;

  @override
  Widget build(BuildContext context) {
    if (type == "list") {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                message!,
                style: textRegular.copyWith(color: AppColor.black400),
              ),
            ),
          ),
        ],
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppIllustration.illustration404,
            width: 240,
            height: 240,
          ),
          const SizedBox(height: 8),
          Text(
            message!,
            style: textRegular.copyWith(color: AppColor.black400),
          ),
        ],
      ),
    );
  }
}
