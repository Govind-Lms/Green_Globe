import 'package:flutter/material.dart';
import 'package:green_globe/src/const/custom_style.dart';

// ignore: non_constant_identifier_names
Text date_time_parser(String date) {
  DateTime? dt;
  try {
    dt = DateTime.parse(date);
  } catch (e) {
    dt = null;
  }
  if (dt == null) {
    return Text(date, style: CustomStyle.twelve);
  }
  // Create a DateFormat for the desired output
  // Use intl: ^0.17.0 or newer in pubspec.yaml
  // Myanmar time zone is UTC+6:30
  final myanmarDuration = const Duration(hours: 6, minutes: 30);
  final myanmarDate = dt.toUtc().add(myanmarDuration);

  final weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final weekday = weekdays[myanmarDate.weekday - 1];
  final month = months[myanmarDate.month - 1];
  final day = myanmarDate.day.toString().padLeft(2, '0');
  final year = myanmarDate.year;

  int hour = myanmarDate.hour;
  final minute = myanmarDate.minute.toString().padLeft(2, '0');
  final second = myanmarDate.second.toString().padLeft(2, '0');
  final ampm = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12 == 0 ? 12 : hour % 12;

  final formattedDate =
      "$weekday, $month $day, $year at $hour:$minute:$second $ampm;\nMyanmar Time";

  return Text(formattedDate, style: CustomStyle.twelve);
}
