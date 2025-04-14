import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latransportindo/app/data/theme/colors.dart';
import 'package:latransportindo/app/data/theme/typography.dart';
import 'package:latransportindo/app/data/widgets/button_default.dart';

class SelectYear extends StatefulWidget {
  const SelectYear({super.key, this.year, this.onTap});
  final int? year;
  final void Function(int)? onTap;
  @override
  State<SelectYear> createState() => _SelectYearState();
}

class _SelectYearState extends State<SelectYear> {
  int index = 0;
  List<int> years = [];

  int findIndex(List<int> list, int? value) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] == value!) {
        return i;
      }
    }
    return -1;
  }

  void initialize() {
    int currentYear = DateTime.now().year;
    for (int year = currentYear; year >= 2023; year--) {
      setState(() {
        years.add(year);
      });
    }
    setState(() {
      index = findIndex(years, widget.year!);
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
              ...years.asMap().entries.map(
                    (e) => Center(
                      child: Text(
                        e.value.toString(),
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
            widget.onTap!(years[index]);
          },
        ),
      ],
    );
  }
}
