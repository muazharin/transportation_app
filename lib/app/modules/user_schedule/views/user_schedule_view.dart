import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/theme/appicons.dart';
import 'package:latransportindo/app/data/theme/appillustrations.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/error_page.dart';
import 'package:latransportindo/app/data/widgets/select_month.dart';
import 'package:latransportindo/app/data/widgets/select_year.dart';
import 'package:latransportindo/app/routes/app_pages.dart';

import '../controllers/user_schedule_controller.dart';

class UserScheduleView extends GetView<UserScheduleController> {
  const UserScheduleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.onInit(),
        child: Column(
          children: [
            GetBuilder<UserScheduleController>(builder: (context) {
              return Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: const BoxDecoration(
                  color: AppColor.blue800,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: selectMonth,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  controller.month.name!,
                                  style: textRegular,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColor.black950,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: selectYear,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  controller.year.toString(),
                                  style: textRegular,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColor.black950,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 74,
                      child: ListView(
                        controller: controller.listController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...controller.days.map(
                            (e) {
                              Color txColor = controller.getTxDateColor(e);
                              return GestureDetector(
                                onTap: () => controller.selectDate(e),
                                child: Container(
                                  width: 40,
                                  margin: const EdgeInsets.only(right: 19),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.getBgDateColor(e),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat("EEE", "id_ID").format(e),
                                        style: textSemiBold.copyWith(
                                          color: txColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        DateFormat("dd", "id_ID").format(e),
                                        style: textSemiBold.copyWith(
                                          color: txColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "Jadwal Saya",
                    style: textSemiBold,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(child: Divider(color: AppColor.black300)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<UserScheduleController>(builder: (context) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.isError) {
                    return ListView(
                      children: [ErrorPage(message: controller.error)],
                    );
                  } else if (controller.list.isEmpty) {
                    return Column(
                      children: [
                        Image.asset(
                          AppIllustration.illustrationnodata,
                          width: 240,
                          height: 240,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Jadwal anda tidak\ntersedia.",
                          textAlign: TextAlign.center,
                          style: textRegular.copyWith(
                            fontSize: 16,
                            color: AppColor.black500,
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView(
                    children: [
                      const SizedBox(height: 12),
                      ...controller.list.asMap().entries.map(
                            (e) => GestureDetector(
                              onTap: () => controller.pickschedule(e.value),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 6,
                                      color: Colors.black.withOpacity(.1),
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      e.key % 2 == 0
                                          ? AppIllustration.illustrationstuff2
                                          : AppIllustration.illustrationstuff1,
                                      width: 83,
                                      height: 83,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Dari",
                                                  style: textRegular.copyWith(
                                                    color: AppColor.black400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  e.value.from!,
                                                  style: textRegular.copyWith(
                                                    color: AppColor.black400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Ke",
                                                  style: textRegular.copyWith(
                                                    color: AppColor.black400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  e.value.destination!,
                                                  style: textRegular.copyWith(
                                                    color: AppColor.black400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Status",
                                                  style: textRegular.copyWith(
                                                    color: AppColor.black400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                flex: 4,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 14,
                                                        vertical: 8,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: controller
                                                            .getBgColor(
                                                                e.value.status),
                                                      ),
                                                      child: Text(
                                                        e.value.status!,
                                                        style: textRegular
                                                            .copyWith(
                                                          color: controller
                                                              .getTxColor(e
                                                                  .value
                                                                  .status),
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectMonth() => Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColor.black300,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Pilih Bulan",
                style: textBold.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: SelectMonth(
                  month: controller.month,
                  onTap: (v) => controller.setMonth(v),
                ),
              ),
            ],
          ),
        ),
      );
  void selectYear() => Get.bottomSheet(
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColor.black300,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Pilih Tahun",
                style: textBold.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: SelectYear(
                  year: controller.year,
                  onTap: (v) => controller.setYear(v),
                ),
              ),
            ],
          ),
        ),
      );
}
