import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutr_frontend/models/arguments/attendance_groups_all_records_args.dart';
import 'package:tutr_frontend/models/arguments/class_material_args.dart';
import 'package:tutr_frontend/models/arguments/doubts_post_arguments.dart';
import 'package:tutr_frontend/models/arguments/invite_memeber_args.dart';
import 'package:tutr_frontend/models/arguments/preview_notes_args.dart';
import 'package:tutr_frontend/models/arguments/student_attendance_screen_args.dart';
import 'package:tutr_frontend/models/arguments/student_id_card_args.dart';
import 'package:tutr_frontend/models/arguments/studnets_list_args.dart';
import 'package:tutr_frontend/models/arguments/take_attendance_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_attendance_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_id_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_view_group_arguments.dart';
import 'package:tutr_frontend/models/arguments/upload_notes_study_material_args.dart';
import 'package:tutr_frontend/routes/app_route_generations.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/viewmodels/auth_bloc/bloc/auth_bloc.dart';
import 'package:tutr_frontend/viewmodels/home_bloc/bloc/home_screen_bloc.dart';
import 'package:tutr_frontend/viewmodels/root_screen_bloc/cubit/root_screen_cubit.dart';

class AppRoutesNavigation with AppRoutesGeneration {
  Route<dynamic>? generate(settings) {
    switch (settings.name) {
      case AppRouteNames.registerScreen:
        return CupertinoPageRoute(
            builder: (context) => routes[AppRouteNames.registerScreen]!(context, settings.arguments as String));

      case AppRouteNames.loginScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => AuthBloc(context: context),
                  child: routes[AppRouteNames.loginScreen]!(context, settings.arguments as String),
                ));

      case AppRouteNames.splashScreen:
        return CupertinoPageRoute(
          builder: (context) => routes[AppRouteNames.splashScreen]!(context, {}),
        );

      case AppRouteNames.homeScreen:
        return CupertinoPageRoute(
          // builder: (context) => routes[AppRouteNames.homeScreen]!(context, {}),
          builder: (context) => BlocProvider(
            create: (context) => HomeScreenBloc()..add(FetchHomeScreenDataEvent()),
            child: routes[AppRouteNames.homeScreen]!(context, {}),
          ),
        );

      case AppRouteNames.rootScreen:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RootScreenDartCubit(),
            child: routes[AppRouteNames.rootScreen]!(context, {}),
          ),
        );

      case AppRouteNames.teacherViewGroup:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.teacherViewGroup]!(context, settings.arguments as TeacherViewGroupArguments),
        );

      case AppRouteNames.uploadNotesScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.uploadNotesScreen]!(context, settings.arguments as UploadNotesStudyMaterialArgs),
        );
      case AppRouteNames.inviteStudentScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.inviteStudentScreen]!(context, settings.arguments as InviteStudentScreenArgs),
        );

      case AppRouteNames.noticeBoardTabScreen:
        return CupertinoPageRoute(
          builder: (context) => routes[AppRouteNames.noticeBoardTabScreen]!(context, settings.arguments as String),
        );
      case AppRouteNames.studentsScreen:
        return CupertinoPageRoute(
          builder: (context) => routes[AppRouteNames.studentsScreen]!(context, settings.arguments as StudnetsListArgs),
        );
      case AppRouteNames.doubtsChatScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.doubtsChatScreen]!(context, settings.arguments as DoubtsPostArguments),
        );
      case AppRouteNames.classNotesScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.classNotesScreen]!(context, settings.arguments as ClassMaterialArgs),
        );
      case AppRouteNames.previewNotesScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.previewNotesScreen]!(context, settings.arguments as PreviewNotesArgs),
        );
      case AppRouteNames.teacherAttendanceScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.teacherAttendanceScreen]!(context, settings.arguments as TeacherAttendanceArgs),
        );
      case AppRouteNames.takeAttendanceScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.takeAttendanceScreen]!(context, settings.arguments as TakeAttendanceArgs),
        );
      case AppRouteNames.attendanceGroupsAllRecordScreen:
        return CupertinoPageRoute(
          builder: (context) => routes[AppRouteNames.attendanceGroupsAllRecordScreen]!(
              context, settings.arguments as AttendanceGroupsAllRecordsArgs),
        );
      case AppRouteNames.attendanceStudentView:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.attendanceStudentView]!(context, settings.arguments as StudentAttendanceScreenArgs),
        );
      case AppRouteNames.teacherIDCardScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.teacherIDCardScreen]!(context, settings.arguments as TeacherIdArgs),
        );
      case AppRouteNames.studentIdCardScreen:
        return CupertinoPageRoute(
          builder: (context) =>
              routes[AppRouteNames.studentIdCardScreen]!(context, settings.arguments as StudentIdCardArgs),
        );

      default:
        return null;
    }
  }
}
