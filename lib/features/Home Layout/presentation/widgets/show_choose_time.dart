import 'package:flutter/material.dart';

Future<DateTime> showChooseDate(BuildContext context, local) async {
  return await showDatePicker(
        locale: local,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        initialDate: DateTime.now(),
      ) ??
      DateTime.now();
}

Future<TimeOfDay> showChooseTime(BuildContext context) async {
  return await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
      TimeOfDay.now();
}
