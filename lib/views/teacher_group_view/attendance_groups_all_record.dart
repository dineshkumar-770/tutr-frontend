// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/app_popups.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/attendance_groups_all_records_args.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/get_attendance_model.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/themes/styles/drop_down_style.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/attendance_calender_tile.dart';
import 'package:tutr_frontend/widgets/teacher_view/teacher_view_group_popups.dart';

class AttendanceGroupsAllRecordScreen extends StatefulWidget {
  const AttendanceGroupsAllRecordScreen({
    super.key,
    required this.allRecordsArgs,
  });
  final AttendanceGroupsAllRecordsArgs allRecordsArgs;

  @override
  State<AttendanceGroupsAllRecordScreen> createState() => _AttendanceGroupsAllRecordScreenState();
}

class _AttendanceGroupsAllRecordScreenState extends State<AttendanceGroupsAllRecordScreen> {
  TeacherViewGroupPopups teacherViewGroupPopups = TeacherViewGroupPopups();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Attendance Records",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
        builder: (context, state) {
          if (state.fetchAttendanceRecordsLoading) {
            return Center(
              child: CustomLoadingWidget(),
            );
          } else if (state.attendanceRecordError.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  state.attendanceRecordError,
                  style: CustomTextStyles.errorTextStyle,
                ),
              ),
            );
          } else {
            if (state.attendanceRecordsData.response != null && state.attendanceRecordsData.response!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: DropDownStyle.getDropDownDecoration(),
                        hint: Text("Select Period"),
                        items: ["Current Month", "Last Month"].map(
                          (e) {
                            return DropdownMenuItem<String>(value: e, child: Text(e));
                          },
                        ).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: state.attendanceRecordsData.response?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AttendanceCalenderTile(
                          record: state.attendanceRecordsData.response![index],
                          isShowingTeacherView: true,
                          isViewFromAllRecords: true,
                          onTapMore: (tapDownDetails) async {
                            final value = await teacherViewGroupPopups.showPopUpMenuAttendance(
                                context: context, position: tapDownDetails.globalPosition, tileWidth: double.maxFinite);

                            if (value == "1") {
                              //loading the original list of record in state variable
                              if (context.mounted) {
                                List<Map<String, dynamic>> originalRecordList = [];
                                for (Attendance record
                                    in (state.attendanceRecordsData.response?[index].attendance ?? [])) {
                                  Map<String, dynamic> recordMap = {
                                    "status": record.status?.name.toLowerCase() ?? "",
                                    "student_id": record.studentId ?? "",
                                    "name": record.name ?? "",
                                    "st_email": record.stEmail ?? "",
                                    "student_phone": record.studentPhone ?? 0
                                  };
                                  originalRecordList.add(recordMap);
                                }

                                context
                                    .read<TeacherViewGroupBloc>()
                                    .add(InitializeOriginalRecordsList(originalList: originalRecordList));

                                //showing bottom sheet after loading the original records in state variable
                                final proceedToAPI = await locatorDI<AppPopups>().showEditAttendanceSheet(
                                  context: context,
                                  attendanceID: state.attendanceRecordsData.response?[index].attendanceId ?? "",
                                  studentsList: state.attendanceRecordsData.response?[index].attendance ?? [],
                                );

                                log(proceedToAPI.toString());
                                if (proceedToAPI == true) {
                                  log(state.markedAttendanceList.toString());
                                  if (context.mounted) {
                                    context.read<TeacherViewGroupBloc>().add(GetAttendanceRecordsEvent(
                                        count: 30,
                                        page: 1,
                                        endDate: DateFormat("dd-MM-yyyy 23:59:59").format(DateTime.now()),
                                        startDate: DateFormat("dd-MM-yyyy 00:00:00")
                                            .format(DateTime.now().subtract(const Duration(days: 30))),
                                        groupId: widget.allRecordsArgs.groupId,
                                        studentId: null,
                                        teacherId: widget.allRecordsArgs.teacherId));
                                  }
                                }
                              }
                            }
                          },
                        );
                      },
                    ))
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    state.attendanceRecordError,
                    style: CustomTextStyles.errorTextStyle,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
