import 'dart:ui';

import 'package:tutr_frontend/models/teacher_view_group_models/get_attendance_model.dart';

class CalenderViewModel {
  final AttendanceRecords records;
  final Color color;
  final int presentCount;

  CalenderViewModel({required this.records, required this.color, required this.presentCount});
}