import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';
import 'package:latransportindo/app/modules/schedule/controllers/schedule_controller.dart';
import 'package:latransportindo/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ListDataView extends GetView<ScheduleController> {
  const ListDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(builder: (context) {
      return Column(
        children: [
          Container(
            height: 360,
            width: Get.width - 32,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.blue50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                SfDateRangePicker(
                  controller: controller.dateController,
                  view: DateRangePickerView.month,
                  // allowViewNavigation: false,
                  showNavigationArrow: true,
                  toggleDaySelection: true,
                  todayHighlightColor: AppColor.blue50,
                  backgroundColor: AppColor.blue50,
                  navigationMode: DateRangePickerNavigationMode.snap,
                  selectionColor: AppColor.yellow500,
                  selectionTextStyle: textRegular.copyWith(color: Colors.white),
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: textRegular.copyWith(
                      fontSize: 14,
                      color: AppColor.blue600,
                    ),
                  ),
                  onSelectionChanged: (v) => controller.detailSchedule(v.value),
                  onViewChanged: (v) =>
                      controller.swapMonth(v.visibleDateRange.startDate),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    firstDayOfWeek: 1,
                    dayFormat: "E",
                    specialDates: controller.list,
                    weekendDays: const [7],
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: textRegular.copyWith(
                        color: AppColor.blue600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: textRegular,
                    todayTextStyle: textRegular.copyWith(
                      color: AppColor.blue600,
                    ),
                    weekendTextStyle: textRegular.copyWith(
                      color: AppColor.error600,
                    ),
                    specialDatesTextStyle:
                        textRegular.copyWith(color: Colors.white),
                    specialDatesDecoration: BoxDecoration(
                      color: AppColor.blue600,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    blackoutDateTextStyle: textRegular,
                    blackoutDatesDecoration: BoxDecoration(
                      border: Border.all(color: AppColor.black950, width: 1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ButtonDefault(
              text: "Tambah Jadwal",
              radius: 24,
              color: AppColor.yellow500,
              onTap: () => Get.toNamed(Routes.ADD_SCHEDULE,
                      arguments: {"date": DateTime.now()})!
                  .then((value) => controller.onRefresh()),
            ),
          )
        ],
      );
    });
  }
}
