import 'package:flutter/cupertino.dart';
import 'package:latransportindo/app/data/dummy/variable.dart';
import 'package:latransportindo/app/data/models/month_model.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';

class SelectMonth extends StatefulWidget {
  const SelectMonth({super.key, required this.month, required this.onTap});
  final MonthModel? month;
  final void Function(MonthModel)? onTap;
  @override
  State<SelectMonth> createState() => _SelectMonthState();
}

class _SelectMonthState extends State<SelectMonth> {
  int index = 0;

  int findIndex(List<MonthModel> list, MonthModel? value) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].name == value!.name) {
        return i;
      }
    }
    return -1;
  }

  void initialize() {
    setState(() {
      index = findIndex(months, widget.month!);
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CupertinoPicker(
            itemExtent: 36,
            onSelectedItemChanged: (index) => setState(() {
              this.index = index;
            }),
            scrollController: FixedExtentScrollController(
              initialItem: index,
            ),
            selectionOverlay: Container(),
            children: [
              ...months.asMap().entries.map(
                    (e) => Center(
                      child: Text(
                        e.value.name!,
                        style: textRegular.copyWith(
                          fontSize: 16,
                          color: e.key == index
                              ? AppColor.black950
                              : AppColor.black300,
                        ),
                      ),
                    ),
                  )
            ],
          ),
        ),
        const SizedBox(height: 16),
        ButtonDefault(
          color: AppColor.yellow500,
          text: "Pilih",
          onTap: () {
            widget.onTap!(months[index]);
          },
        ),
      ],
    );
  }
}
