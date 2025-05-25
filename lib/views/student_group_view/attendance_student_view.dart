import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/transparent_button.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/student_attendance_screen_args.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/calender_view_model.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/attendance_calender_tile.dart';

class AttendanceStudentView extends StatefulWidget {
  const AttendanceStudentView({super.key, required this.studentAttendanceScreenArgs});
  final StudentAttendanceScreenArgs studentAttendanceScreenArgs;

  @override
  State<AttendanceStudentView> createState() => _AttendanceStudentViewState();
}

class _AttendanceStudentViewState extends State<AttendanceStudentView> {
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
                  state.attendanceRecordError,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.errorTextStyle,
                ),
              ),
            );
          } else {
            if (state.attendanceRecordsData.response != null && state.attendanceRecordsData.response!.isNotEmpty) {
              return Column(
                children: [
                  TableCalendar(
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    firstDay: DateTime.utc(2020),
                    lastDay: DateTime.utc(2030),
                    focusedDay: state.focusedDay,
                    selectedDayPredicate: (day) {
                      final isSame = isSameDay(day, state.selectedDay);
                      return isSame;
                    },
                    calendarFormat: CalendarFormat.month,
                    daysOfWeekHeight: 32,
                    eventLoader: (day) {
                      final resetDate = DateTime(day.year, day.month, day.day);
                      return state.calenderData[resetDate] ?? [];
                    },
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (selectedDay, focusedDay) {
                      context
                          .read<TeacherViewGroupBloc>()
                          .add(OnSelectedDateEvent(focusedDay: focusedDay, selectedDay: selectedDay));
                    },
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: AppColors.amber,
                        shape: BoxShape.circle,
                      ),
                      isTodayHighlighted: true,
                      canMarkersOverflow: false,
                      todayDecoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: AppColors.white),
                      weekendTextStyle: TextStyle(color: Colors.orange),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty && events.first is CalenderViewModel) {
                          final model = events.first as CalenderViewModel;
                          final attendanceList = model.records.attendance;

                          log("Date: $date => Attendance list: $attendanceList", name: "Events cal");

                          // Check if attendance list is not null and not empty
                          if (attendanceList != null && attendanceList.isNotEmpty) {
                            return Center(
                              child: Icon(
                                Icons.check,
                                size: 30,
                                color: AppColors.presentColor,
                              ),
                            );
                          } else {
                            return Center(
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.redAccent,
                              ),
                            );
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    onPageChanged: (focusedDay) {
                      log(focusedDay.toIso8601String());
                    },
                  ),
                  const SizedBox(height: 8),
                  if ((state.calenderData[DateTime.parse(
                              DateFormat("yyyy-MM-dd 00:00:00.000").format(state.selectedDay ?? DateTime.now()))])
                          ?.isNotEmpty ??
                      false) ...[
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<TeacherViewGroupBloc>().add(GetAttendanceRecordsEvent(
                              count: 30,
                              page: 1,
                              endDate: DateFormat("dd-MM-yyyy 23:59:59").format(DateTime.now()),
                              startDate: DateFormat("dd-MM-yyyy 00:00:00")
                                  .format(DateTime.now().subtract(const Duration(days: 30))),
                              groupId: widget.studentAttendanceScreenArgs.groupId,
                              studentId: widget.studentAttendanceScreenArgs.studentId,
                              teacherId: widget.studentAttendanceScreenArgs.teacherId));
                        },
                        child: ListView.builder(
                          itemCount: (state.calenderData[DateTime.parse(DateFormat("yyyy-MM-dd 00:00:00.000")
                                      .format(state.selectedDay ?? DateTime.now()))])
                                  ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            final calEvent = (state.calenderData[DateTime.parse(
                                    DateFormat("yyyy-MM-dd 00:00:00.000").format(state.selectedDay ?? DateTime.now()))]
                                ?[index]);

                            return AttendanceCalenderTile(
                              record: calEvent!.records,
                              isViewFromAllRecords: false,
                              isShowingTeacherView: false,
                            );
                          },
                        ),
                      ),
                    )
                  ] else ...[
                    Gaps.verticalGap(value: 100),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          spacing: 16,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "No records found on dated ${locatorDI<Helper>().formatDateinDDMMMYYYY(state.selectedDay ?? DateTime.now())}",
                              style: TextStyle(color: AppColors.textColor2, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            TransparentButton(
                              label: "Refresh Records",
                              icon: Icons.refresh,
                              onTap: () {
                                context.read<TeacherViewGroupBloc>().add(GetAttendanceRecordsEvent(
                                    count: 30,
                                    page: 1,
                                    endDate: DateFormat("dd-MM-yyyy 23:59:59").format(DateTime.now()),
                                    startDate: DateFormat("dd-MM-yyyy 00:00:00")
                                        .format(DateTime.now().subtract(const Duration(days: 30))),
                                    groupId: widget.studentAttendanceScreenArgs.groupId,
                                    studentId: widget.studentAttendanceScreenArgs.studentId,
                                    teacherId: widget.studentAttendanceScreenArgs.teacherId));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    style: CustomTextStyles.errorTextStyle,
                    state.attendanceRecordError,
                    textAlign: TextAlign.center,
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
