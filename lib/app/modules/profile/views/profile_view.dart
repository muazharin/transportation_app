import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/custom_appbar.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Profil Saya"),
      body: GetBuilder<ProfileController>(builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(AppIcons.iconuserprofile2,
                    width: 64, height: 64),
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListTile(
                    leading: Image.asset(
                      AppIcons.iconfillname,
                      width: 24,
                      height: 24,
                      color: AppColor.black300,
                    ),
                    title: Text(
                      "${controller.authModel.nama}",
                      style: textRegular.copyWith(color: AppColor.black300),
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(
                      AppIcons.iconfillphone,
                      width: 24,
                      height: 24,
                      color: AppColor.black300,
                    ),
                    title: Text(
                      "${controller.authModel.nomorTelepon}",
                      style: textRegular.copyWith(color: AppColor.black300),
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(
                      AppIcons.iconfillperson,
                      width: 24,
                      height: 24,
                      color: AppColor.black300,
                    ),
                    title: Text(
                      "${controller.authModel.userType}",
                      style: textRegular.copyWith(color: AppColor.black300),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => controller.logout(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 19),
                  decoration: BoxDecoration(
                    color: AppColor.error600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Keluar",
                        style: textRegular.copyWith(
                            fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        AppIcons.iconfilllogout,
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
