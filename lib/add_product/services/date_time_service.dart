import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeService {
  static Future<void> showDateTimePicker(
      BuildContext context, void Function(DateTime) onChanged) {
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.white,
          child: CupertinoDatePicker(
            maximumDate: DateTime(2024),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: onChanged,
            initialDateTime: DateTime.now(),
            minimumYear: 2000,
            maximumYear: 3000,
          ),
        );
      },
    );
  }
}
