// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutr_frontend/constants/app_colors.dart';

import 'package:tutr_frontend/models/arguments/teacher_attendance_args.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({
    super.key,
    required this.teacherAttendanceArgs,
  });
  final TeacherAttendanceArgs teacherAttendanceArgs;

  @override
  State<TeacherAttendanceScreen> createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Object?>> manualData = {};

  List<Object?> manualEventLoader(DateTime date) {
    return manualData[date] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    for (int i = 0; i < 10; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: i));
      DateTime resetDate = DateTime(date.year, date.month, date.day);
      String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").format(resetDate);
      DateTime dateTime = DateTime.parse(formattedDate).toUtc();
      manualData[dateTime] = ['Present $i', i < 5 ? AppColors.red : AppColors.primaryColor];
    }

    log(manualData.toString());
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Attendance",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            daysOfWeekHeight: 32,
            eventLoader: (day) {
              return manualEventLoader(day);
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: Colors.orange),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: events[1] as Color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        Text(
                          date.day.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          events.first.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: manualData.length,
              itemBuilder: (context, index) {
                return Text(manualData.values.toList()[index][0].toString());
              },
            ),
          )
          // Expanded(
          //   child: ListView(
          //     children: (_selectedDay == null
          //             ? manualData.entries
          //             : manualData.entries.where((entry) =>
          //                 DateTime(entry.key.year, entry.key.month, entry.key.day) ==
          //                 DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)))
          //         .map((entry) => Container(
          //               padding: const EdgeInsets.all(8),
          //               child: Row(
          //                 children: [
          //                   Text(entry.key.toString()),
          //                   const Spacer(),
          //                   Text(entry.value.first.toString()),
          //                 ],
          //               ),
          //             ))
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
