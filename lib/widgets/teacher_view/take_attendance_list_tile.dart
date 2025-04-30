// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';

class TakeAttendanceListTile extends StatefulWidget {
  final Function(StudentAttendanceStatus) onAttendanceMarked;
  final String studentName;

  const TakeAttendanceListTile({
    super.key,
    required this.onAttendanceMarked,
    required this.studentName,
  });

  @override
  State<TakeAttendanceListTile> createState() => _TakeAttendanceListTileState();
}

class _TakeAttendanceListTileState extends State<TakeAttendanceListTile> {
  StudentAttendanceStatus? selectedStatus;

  void handleAttendanceTap(StudentAttendanceStatus status) {
    setState(() {
      selectedStatus = status;
    });
    widget.onAttendanceMarked(status);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0x0ffffff9), borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: AppColors.grey, // Shadow color
          offset: Offset(0, 6), // Bottom me shadow ka position, yeh value badhane se bottom shadow zyada hoga
          blurRadius: 6, // Blur ka size (softer shadow effect)
          spreadRadius: 3, // Shadow ka spread, yeh value thoda increase kar sakte ho
          blurStyle: BlurStyle.outer,
        )
      ]),
      child: Center(
        child: ListTile(
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              widget.studentName,
              style: TextStyle(
                color: AppColors.textColor2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAttendanceButton("P", AppColors.presentColor, StudentAttendanceStatus.PRESENT),
              const SizedBox(width: 15),
              buildAttendanceButton("A", AppColors.absentColor, StudentAttendanceStatus.ABSENT),
              const SizedBox(width: 15),
              buildAttendanceButton("Lt", AppColors.lateColor, StudentAttendanceStatus.LATE),
              const SizedBox(width: 15),
              buildAttendanceButton("Le", AppColors.leaveColor, StudentAttendanceStatus.LEAVE),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAttendanceButton(String label, Color color, StudentAttendanceStatus status) {
    final bool isSelected = selectedStatus == status;
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () => handleAttendanceTap(status),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            // gradient: isSelected
            //     ? LinearGradient(
            //         colors: [color, Color(0xFFE1BEE7)], begin: Alignment.topLeft, end: Alignment.bottomRight)
            //     : null,
            color: color,
            // border: isSelected ? Border.all(color: AppColors.primaryColor, width: 2) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (isSelected) ...[
                Icon(
                  Icons.check_circle,
                  color: AppColors.white,
                  size: 20,
                ),
              ],
              Text(
                label,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
