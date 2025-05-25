// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/transparent_button.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/attendance_groups_all_records_args.dart';
import 'package:tutr_frontend/models/arguments/take_attendance_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_attendance_args.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/calender_view_model.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/attendance_calender_tile.dart';

class TeacherAttendanceScreen extends StatelessWidget {
  const TeacherAttendanceScreen({
    super.key,
    required this.teacherAttendanceArgs,
  });
  final TeacherAttendanceArgs teacherAttendanceArgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TeacherViewGroupBloc>().add(FetchGroupMembersEvent(
              context: context, groupId: teacherAttendanceArgs.groupId, ownerId: teacherAttendanceArgs.teacherId));
          Navigator.pushNamed(context, AppRouteNames.takeAttendanceScreen,
              arguments: TakeAttendanceArgs(groupId: teacherAttendanceArgs.groupId));
        },
        child: Icon(FontAwesomeIcons.add),
      ),
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
                      CalendarFormat.twoWeeks: '2 weeks',
                    },
                    firstDay: DateTime.utc(2020),
                    lastDay: DateTime.utc(2030),
                    focusedDay: state.focusedDay,
                    selectedDayPredicate: (day) {
                      final isSame = isSameDay(day, state.selectedDay);
                      return isSame;
                    },
                    calendarFormat: CalendarFormat.twoWeeks,
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
                          return Center(
                              child: Icon(
                            Icons.check,
                            size: 30,
                            color: AppColors.presentColor,
                          ));
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
                              groupId: teacherAttendanceArgs.groupId,
                              studentId: null,
                              teacherId: teacherAttendanceArgs.teacherId));
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
                              isShowingTeacherView: true,
                              isViewFromAllRecords: false,
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
                            Row(
                              spacing: 10,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TransparentButton(
                                    icon: Icons.schedule,
                                    onTap: () {
                                      context.read<TeacherViewGroupBloc>().add(FetchGroupMembersEvent(
                                          context: context,
                                          groupId: teacherAttendanceArgs.groupId,
                                          ownerId: teacherAttendanceArgs.teacherId));
                                      Navigator.pushNamed(context, AppRouteNames.takeAttendanceScreen,
                                          arguments: TakeAttendanceArgs(groupId: teacherAttendanceArgs.groupId));
                                    },
                                    label: "Mark Today's Attendance",
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TransparentButton(
                                    label: "Refresh Records",
                                    icon: Icons.refresh,
                                    onTap: () {
                                      context.read<TeacherViewGroupBloc>().add(GetAttendanceRecordsEvent(
                                          count: 30,
                                          page: 1,
                                          endDate: DateFormat("dd-MM-yyyy 23:59:59").format(DateTime.now()),
                                          startDate: DateFormat("dd-MM-yyyy 00:00:00")
                                              .format(DateTime.now().subtract(const Duration(days: 30))),
                                          groupId: teacherAttendanceArgs.groupId,
                                          studentId: null,
                                          teacherId: teacherAttendanceArgs.teacherId));
                                    },
                                  ),
                                )
                              ],
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 10,
              children: [
                TutrPrimaryButton(
                  onPressed: () {
                    context.read<TeacherViewGroupBloc>().add(GetAttendanceRecordsEvent(
                        count: 30,
                        page: 1,
                        endDate: DateFormat("dd-MM-yyyy 23:59:59").format(DateTime.now()),
                        startDate:
                            DateFormat("dd-MM-yyyy 00:00:00").format(DateTime.now().subtract(const Duration(days: 30))),
                        groupId: teacherAttendanceArgs.groupId,
                        studentId: null,
                        teacherId: teacherAttendanceArgs.teacherId));
                    Navigator.pushNamed(context, AppRouteNames.attendanceGroupsAllRecordScreen,
                        arguments: AttendanceGroupsAllRecordsArgs(
                          groupId: teacherAttendanceArgs.groupId,
                          studentId: "",
                          teacherId: teacherAttendanceArgs.teacherId,
                        ));
                  },
                  width: MediaQuery.of(context).size.width / 2,
                  label: "All Records",
                  icon: Icon(
                    FontAwesomeIcons.list,
                    color: AppColors.white,
                  ),
                  fontSize: 12,
                ),
                TutrPrimaryButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.analytics_outlined,
                    color: AppColors.white,
                    size: 22,
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  label: "Analyize Records",
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
