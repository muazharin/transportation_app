import 'package:flutter/material.dart';

class DatePickerWidgetInner extends StatelessWidget {
  const DatePickerWidgetInner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
              onDateChanged: (DateTime newDate) {
                // controller.selectedDate.value = newDate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
