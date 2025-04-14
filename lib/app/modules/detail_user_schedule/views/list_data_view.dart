import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latransportindo/app/data/models/detail_user_schedule.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/data/widgets/pop_up_status.dart';
import 'package:latransportindo/app/data/widgets/pop_up_succes.dart';
import 'package:latransportindo/app/modules/detail_user_schedule/controllers/detail_user_schedule_controller.dart';

class ListDataView extends GetView<DetailUserScheduleController> {
  const ListDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color circleColor(String? status, bool? isEnd) {
      if (status!.isNotEmpty && !isEnd!) {
        return AppColor.blue600;
      } else if (status.isNotEmpty && isEnd!) {
        return AppColor.success600;
      }
      return Colors.white;
    }

    Color lineColor(MapEntry<int, Location> e, bool? isEnd) {
      if (!isEnd!) {
        if (controller.data.location![e.key + 1].statusLoading != null) {
          return AppColor.blue600;
        }
      }
      return AppColor.black200;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<DetailUserScheduleController>(builder: (context) {
        return ListView(
          children: [
            const SizedBox(height: 24),
            ...controller.data.location!.asMap().entries.map(
              (e) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat("dd MMMM", "id_ID").format(
                              controller.data.tanggalTugas!,
                            ),
                            style:
                                textRegular.copyWith(color: AppColor.black400),
                          ),
                          e.value.jam != null
                              ? Column(children: [
                                  Text(e.value.jam, style: textRegular),
                                  const SizedBox(height: 120)
                                ])
                              : const SizedBox(height: 150),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Container(
                            height: 21,
                            width: 21,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              color: circleColor(
                                e.value.statusLoading ?? "",
                                e.key == controller.data.location!.length - 1,
                              ),
                              borderRadius: BorderRadius.circular(21),
                              border: Border.all(color: AppColor.blue100),
                            ),
                            child: e.key == controller.data.location!.length - 1
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 10,
                                  )
                                : const SizedBox(),
                          ),
                          SizedBox(
                            height:
                                controller.data.location!.length - 1 == e.key
                                    ? 0
                                    : 150,
                            child: VerticalDivider(
                              color: lineColor(
                                e,
                                e.key == controller.data.location!.length - 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.value.nama!,
                            style: textRegular,
                          ),
                          e.value.statusLoading != null
                              ? Text(
                                  e.value.statusLoading!,
                                  style: textRegular.copyWith(
                                    color: AppColor.black400,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      }),
      bottomNavigationBar:
          GetBuilder<DetailUserScheduleController>(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ButtonDefault(
                text: "Update Status",
                radius: 32,
                color: AppColor.yellow500,
                onTap: () {
                  if (controller.data.location!.last.statusLoading == null) {
                    Get.dialog(PopUpStatus(
                        onTap: (v) => controller.isTodayOrFuture(v)));
                  } else {
                    Get.dialog(PopUpSuccess(
                      title: "Pengiriman Selesai",
                      btnText: "OK",
                      onTap: () => Get.back(),
                      detail:
                          "Anda sudah menyelesaikan pengiriman. Kamu bisa melihat detail status pengiriman sekarang.",
                    ));
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
