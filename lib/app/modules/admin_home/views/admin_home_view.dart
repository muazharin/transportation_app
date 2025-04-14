import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/float_menu.dart';
import 'package:latransportindo/app/data/widgets/home_menu.dart';
import 'package:latransportindo/app/routes/app_pages.dart';
import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.blue800,
        automaticallyImplyLeading: false,
        toolbarHeight: 88,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "logo",
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          AppIcons.truck,
                          width: 32,
                          height: 32,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "LA Transportindo",
                      textAlign: TextAlign.center,
                      style: textSemiBold.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.PROFILE),
                child: Image.asset(
                  AppIcons.iconuserprofile,
                  width: 36,
                  height: 36,
                ),
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      body: GetBuilder<AdminHomeController>(builder: (context) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColor.blue50,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            HomeMenu(
                              title: "Jadwal",
                              path: AppIcons.iconfillcalendar,
                              onTap: () =>
                                  controller.selectMenu(route: Routes.SCHEDULE),
                            ),
                            HomeMenu(
                              title: "Pengguna",
                              path: AppIcons.iconoutlineuser,
                              onTap: () =>
                                  controller.selectMenu(route: Routes.USERS),
                            ),
                            HomeMenu(
                              title: "Kendaraan",
                              path: AppIcons.iconoutlinevehicle,
                              onTap: () =>
                                  controller.selectMenu(route: Routes.VEHICLES),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            HomeMenu(
                              title: "Pelanggan",
                              path: AppIcons.iconoutlinecustomer,
                              onTap: () => controller.selectMenu(
                                  route: Routes.CUSTOMERS),
                            ),
                            HomeMenu(
                              title: "Lokasi",
                              path: AppIcons.iconoutlineaddress,
                              onTap: () => controller.selectMenu(
                                  route: Routes.LOCATIONS),
                            ),
                            HomeMenu(
                              title: "Live Report",
                              path: AppIcons.iconoutlinelivereport,
                              onTap: () => controller.selectMenu(
                                  route: Routes.LIVE_REPORT),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView(
                        children: [
                          controller.list.isNotEmpty
                              ? ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: Text(
                                    "Jadwal hari ini",
                                    style: textRegular.copyWith(
                                      color: AppColor.blue600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    DateFormat("dd MMMM yyyy", 'id_ID')
                                        .format(DateTime.now()),
                                    style: textRegular.copyWith(
                                      color: AppColor.black300,
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: InkWell(
                                      onTap: () =>
                                          controller.detailScheduleToday(),
                                      child: Text(
                                        "Lihat Semua",
                                        style: textRegular.copyWith(
                                          color: AppColor.black300,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          ...controller.list.map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.nama!.nama!, style: textRegular),
                                Text(
                                  e.vehicle!.nama!.toUpperCase(),
                                  style: textRegular.copyWith(
                                    fontSize: 12,
                                    color: AppColor.black300,
                                  ),
                                ),
                                const Divider(color: AppColor.black300)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              AnimatedPositioned(
                bottom: !controller.isShowFloatMenu ? -400 : 8,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                child: SizedBox(
                  width: Get.width,
                  child: Center(
                    child: Container(
                      width: 211,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: .4,
                            color: Colors.black.withOpacity(.15),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FloatMenu(
                            isSelected: controller.selectedFloat == "Lokasi",
                            title: "Tambah Lokasi",
                            path: AppIcons.iconoutlineaddress,
                            onTap: () => controller.setSelectedFloat(
                              v: "Lokasi",
                              routes: Routes.ADD_LOCATION,
                              routeMenu: Routes.LOCATIONS,
                            ),
                          ),
                          FloatMenu(
                            isSelected: controller.selectedFloat == "Pelanggan",
                            title: "Tambah Pelanggan",
                            path: AppIcons.iconoutlinecustomer,
                            onTap: () => controller.setSelectedFloat(
                              v: "Pelanggan",
                              routes: Routes.ADD_CUSTOMER,
                              routeMenu: Routes.CUSTOMERS,
                            ),
                          ),
                          FloatMenu(
                            isSelected: controller.selectedFloat == "Kendaraan",
                            title: "Tambah Kendaraan",
                            path: AppIcons.iconoutlinevehicle,
                            onTap: () => controller.setSelectedFloat(
                              v: "Kendaraan",
                              routes: Routes.ADD_VEHICLE,
                              routeMenu: Routes.VEHICLES,
                            ),
                          ),
                          FloatMenu(
                            isSelected: controller.selectedFloat == "Pengguna",
                            title: "Tambah Pengguna",
                            path: AppIcons.iconoutlineuser,
                            onTap: () => controller.setSelectedFloat(
                              v: "Pengguna",
                              routes: Routes.ADD_USER,
                              routeMenu: Routes.USERS,
                            ),
                          ),
                          FloatMenu(
                            isSelected: controller.selectedFloat == "Jadwal",
                            title: "Tambah Jadwal",
                            path: AppIcons.iconoutlinecalendar,
                            onTap: () => controller.setSelectedFloat(
                              v: "Jadwal",
                              routes: Routes.ADD_SCHEDULE,
                              arg: {"date": DateTime.now()},
                              routeMenu: Routes.SCHEDULE,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: GetBuilder<AdminHomeController>(builder: (context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                color: AppColor.black100,
                height: 0,
                indent: 0,
                thickness: 1,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.blue100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(
                            AppIcons.iconfillhome,
                            width: 24,
                            height: 24,
                            color: AppColor.blue700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Beranda",
                          style: textBold.copyWith(
                              fontSize: 12, color: AppColor.blue700),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.showFloatMenu(),
                    child: RotationTransition(
                      turns: controller.animation,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: controller.isShowFloatMenu
                              ? AppColor.error600
                              : AppColor.yellow500,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Image.asset(
                          controller.isShowFloatMenu
                              ? AppIcons.iconfillclose
                              : AppIcons.iconfilladd,
                          width: 40,
                          height: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppIcons.iconoutlineperson,
                            width: 24,
                            height: 24,
                            color: AppColor.black400,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Profil",
                            style: textBold.copyWith(
                                fontSize: 12, color: AppColor.black400),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}
