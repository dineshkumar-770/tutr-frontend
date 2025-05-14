import 'package:flutter/material.dart';
import 'package:tutr_frontend/models/arguments/invite_memeber_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_view_group_arguments.dart';
import 'package:tutr_frontend/models/arguments/upload_notes_study_material_args.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/views/auth_screen/login_screen.dart';
import 'package:tutr_frontend/views/auth_screen/register_screen.dart';
import 'package:tutr_frontend/views/home_screen/home_screen.dart';
import 'package:tutr_frontend/views/root_screen/root_screen.dart';
import 'package:tutr_frontend/views/splash/splash_screen.dart';
import 'package:tutr_frontend/views/teacher_group_view/attendance_groups_all_record.dart';
import 'package:tutr_frontend/views/teacher_group_view/class_notes_tab.dart';
import 'package:tutr_frontend/views/teacher_group_view/doubts_chat_tab.dart';
import 'package:tutr_frontend/views/teacher_group_view/invite_student_screen.dart';
import 'package:tutr_frontend/views/teacher_group_view/notice_board_tab.dart';
import 'package:tutr_frontend/views/teacher_group_view/preview_notes.screen.dart';
import 'package:tutr_frontend/views/teacher_group_view/students_list_tab.dart';
import 'package:tutr_frontend/views/teacher_group_view/take_attendance.dart';
import 'package:tutr_frontend/views/teacher_group_view/teacher_attendance.dart';
import 'package:tutr_frontend/views/teacher_group_view/teacher_view_group.dart';
import 'package:tutr_frontend/views/teacher_group_view/upload_notes_screen.dart';

mixin AppRoutesGeneration {
  final Map<String, Widget Function(BuildContext, dynamic)> _routes = {
    AppRouteNames.registerScreen: (context, args) => RegisterScreen(
          registerType: args,
        ),
    AppRouteNames.splashScreen: (context, args) => SplashScreen(),
    AppRouteNames.loginScreen: (context, args) => LoginScreen(
          userType: args,
        ),
    AppRouteNames.homeScreen: (context, args) => HomeScreen(),
    AppRouteNames.rootScreen: (context, args) => RootScreen(),
    AppRouteNames.teacherViewGroup: (context, args) => TeacherViewGroup(
          teacherViewGroupArguments: args as TeacherViewGroupArguments,
        ),
    AppRouteNames.uploadNotesScreen: (context, args) => UploadNotesScreen(
          uploadNotesStudyMaterialArgs: args as UploadNotesStudyMaterialArgs,
        ),
    AppRouteNames.inviteStudentScreen: (context, args) => InviteStudentScreen(
          inviteStudentScreenArgs: args as InviteStudentScreenArgs,
        ),
    AppRouteNames.noticeBoardTabScreen: (context, args) => NoticeBoardTab(
          groupId: args,
        ),
    AppRouteNames.studentsScreen: (context, args) => StudentsListTab(
          studnetsListArgs: args,
        ),
    AppRouteNames.doubtsChatScreen: (context, args) => DoubtsChatTab(),
    AppRouteNames.attendanceScreen: (context, args) => NoticeBoardTab(
          groupId: args,
        ),
    AppRouteNames.classNotesScreen: (context, args) => ClassNotesTab(
          classMaterialArgs: args,
        ),
    AppRouteNames.previewNotesScreen: (context, args) => PreviewNotes(
          previewNotesArgs: args,
        ),
    AppRouteNames.teacherAttendanceScreen: (context, args) => TeacherAttendanceScreen(
          teacherAttendanceArgs: args,
        ),
    AppRouteNames.takeAttendanceScreen: (context, args) => TakeAttendanceScreen(
          takeAttendanceArgs: args,
        ),
    AppRouteNames.attendanceGroupsAllRecordScreen: (context, args) => AttendanceGroupsAllRecordScreen(
          allRecordsArgs: args,
        ),
  };

  Map<String, Widget Function(BuildContext, dynamic)> get routes {
    return _routes;
  }
}
