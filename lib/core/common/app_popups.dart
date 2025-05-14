import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/get_attendance_model.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/take_attendance_list_tile.dart';

class AppPopups {
  Future showGeneralInfoPop(
      {required BuildContext context,
      required double height,
      required String title,
      required List<Widget>? actionButtons,
      required List<Widget> content}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: AppColors.textColor2),
          ),
          actions: actionButtons,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          content: SizedBox(
            height: height,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: content),
          ),
        );
      },
    );
  }

  Future<bool?> showEditAttendanceSheet(
      {required BuildContext context, required List<Attendance> studentsList, required String attendanceID}) async {
    final height = MediaQuery.of(context).size.height * 0.6;

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          enableDrag: true,
          showDragHandle: true,
          builder: (context) {
            return SafeArea(
              child: BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
                builder: (context, state) {
                  return SizedBox(
                    height: height, // 👈 60% screen height fixed
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: studentsList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TakeAttendanceListTile(
                                    onAttendanceMarked: (value) {
                                      final Map<String, dynamic> record = {
                                        "status": value.name.toLowerCase(),
                                        "student_id": studentsList[index].studentId ?? "",
                                        "name": studentsList[index].name ?? "",
                                        "st_email": studentsList[index].stEmail ?? "",
                                        "student_phone": studentsList[index].studentPhone ?? 0
                                      };
                                      context
                                          .read<TeacherViewGroupBloc>()
                                          .add(MarkAttendanceEvent(attendanceRecord: record));
                                    },
                                    studentName: studentsList[index].name ?? "",
                                    prefilledStatus: studentsList[index].status,
                                  ),
                                );
                              },
                            ),
                          ),
                          TutrPrimaryButton(
                            onPressed: () {
                              log(state.markedAttendanceList.toString());
                              context.read<TeacherViewGroupBloc>().add(UpdateBulkRecordsAttendance(
                                  attendanceId: attendanceID,
                                  context: context,
                                  updatedRecords: state.markedAttendanceList));
                            },
                            label: state.updateRecordsLoading ? "Hold on...updaing your records" : "Save",
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );

    return result; // true if saved, null otherwise
  }
}
