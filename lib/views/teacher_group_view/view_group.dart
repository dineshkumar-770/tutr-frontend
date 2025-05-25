// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/models/arguments/class_material_args.dart';
import 'package:tutr_frontend/models/arguments/student_attendance_screen_args.dart';
import 'package:tutr_frontend/models/arguments/studnets_list_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_attendance_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_view_group_arguments.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';

class TeacherViewGroup extends StatefulWidget {
  const TeacherViewGroup({
    super.key,
    required this.teacherViewGroupArguments,
  });
  final TeacherViewGroupArguments teacherViewGroupArguments;

  @override
  State<TeacherViewGroup> createState() => _TeacherViewGroupState();
}

class _TeacherViewGroupState extends State<TeacherViewGroup> with TickerProviderStateMixin {
  List<String> groupFeatursName = ["Notice Board", "Students", "Doubt Chat", "Class Material", "Attendance"];
  List<String> icons = [
    "assets/images/noticeboard.png",
    "assets/images/students.png",
    "assets/images/conversation.png",
    "assets/images/book.png",
    "assets/images/immigration.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          widget.teacherViewGroupArguments.groupTitle,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 3 / 4),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, AppRouteNames.noticeBoardTabScreen,
                        arguments: widget.teacherViewGroupArguments.groupId);
                    context.read<TeacherViewGroupBloc>().add(
                        FetchNoticeForGroupEvent(groupId: widget.teacherViewGroupArguments.groupId, context: context));
                    break;

                  case 1:
                    Navigator.pushNamed(context, AppRouteNames.studentsScreen,
                        arguments: StudnetsListArgs(
                            className: widget.teacherViewGroupArguments.className,
                            teacherId: widget.teacherViewGroupArguments.teacherId,
                            groupId: widget.teacherViewGroupArguments.groupId,
                            teacherName: widget.teacherViewGroupArguments.teacherName));
                    context.read<TeacherViewGroupBloc>().add(FetchGroupMembersEvent(
                        context: context,
                        groupId: widget.teacherViewGroupArguments.groupId,
                        ownerId: widget.teacherViewGroupArguments.teacherId));

                  case 2:
                    Navigator.pushNamed(context, AppRouteNames.doubtsChatScreen);

                  case 3:
                    Navigator.pushNamed(context, AppRouteNames.classNotesScreen,
                        arguments: ClassMaterialArgs(
                            className: widget.teacherViewGroupArguments.className,
                            groupId: widget.teacherViewGroupArguments.groupId));
                    context.read<TeacherViewGroupBloc>().add(
                        FetchGroupMaterialNotes(context: context, groupId: widget.teacherViewGroupArguments.groupId));

                  case 4:
                    if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) {
                      Navigator.pushNamed(context, AppRouteNames.teacherAttendanceScreen,
                          arguments: TeacherAttendanceArgs(
                              groupId: widget.teacherViewGroupArguments.groupId,
                              teacherId: widget.teacherViewGroupArguments.teacherId));
                      log(Prefs.getString(ConstantStrings.userToken));
                      context.read<TeacherViewGroupBloc>().add(GetAttendanceRecordsEvent(
                          count: 30,
                          page: 1,
                          endDate: DateFormat("dd-MM-yyyy 23:59:59").format(DateTime.now()),
                          startDate: DateFormat("dd-MM-yyyy 00:00:00")
                              .format(DateTime.now().subtract(const Duration(days: 30))),
                          groupId: widget.teacherViewGroupArguments.groupId,
                          studentId: null,
                          teacherId: widget.teacherViewGroupArguments.teacherId));
                    } else if (locatorDI<Helper>().getUserType() == ConstantStrings.student) {
                      Navigator.pushNamed(context, AppRouteNames.attendanceStudentView,
                          arguments: StudentAttendanceScreenArgs(
                              groupId: widget.teacherViewGroupArguments.groupId,
                              studentId: Prefs.getString(ConstantStrings.userId),
                              teacherId: widget.teacherViewGroupArguments.teacherId));
                      final studentId = Prefs.getString(ConstantStrings.userId);
                      if (studentId.isNotEmpty) {
                        context.read<TeacherViewGroupBloc>().add(GetAttendanceRecordsEvent(
                            count: 30,
                            page: 1,
                            endDate: DateFormat("dd-MM-yyyy 23:59:59").format(DateTime.now()),
                            startDate: DateFormat("dd-MM-yyyy 00:00:00")
                                .format(DateTime.now().subtract(const Duration(days: 30))),
                            groupId: widget.teacherViewGroupArguments.groupId,
                            studentId: studentId,
                            teacherId: widget.teacherViewGroupArguments.teacherId));
                      }
                    }
                  default:
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage(icons[index]),
                        height: 120,
                        width: 120,
                      ),
                      Gaps.verticalGap(value: 20),
                      Text(
                        groupFeatursName[index],
                        style: TextStyle(color: AppColors.textColor3, fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
