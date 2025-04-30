// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/models/arguments/take_attendance_args.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/take_attendance_list_tile.dart';

class TakeAttendanceScreen extends StatefulWidget {
  const TakeAttendanceScreen({
    super.key,
    required this.takeAttendanceArgs,
  });
  final TakeAttendanceArgs takeAttendanceArgs;

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  TextEditingController remarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Take Attendance",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<TeacherViewGroupBloc, TeacherViewGroupState>(
          listener: (context, state) {
            if (state.saveAttendanceError.isNotEmpty) {
              CustomToast.show(toastType: ToastificationType.error, context: context, title: state.saveAttendanceError);
            }
          },
          builder: (context, state) {
            if (state.fetchmembersLoading) {
              return Center(
                child: CustomLoadingWidget(),
              );
            } else if (state.fetchMembersError.isNotEmpty) {
              return Center(
                child: Text(
                  state.fetchMembersError,
                  style: CustomTextStyles.errorTextStyle,
                ),
              );
            } else if (state.groupMembersList.isNotEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(label: "Remarks", hint: "Any remarks?", controller: remarksController),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    itemCount: state.groupMembersList.length,
                    itemBuilder: (context, index) {
                      return TakeAttendanceListTile(
                        onAttendanceMarked: (status) {
                          final Map<String, dynamic> record = {
                            "status": status.name.toLowerCase(),
                            "student_id": state.groupMembersList[index].studentId ?? "",
                            "name": state.groupMembersList[index].studentFullName ?? "",
                            "st_email": state.groupMembersList[index].studentEmail ?? "",
                            "student_phone": state.groupMembersList[index].studentContact ?? 0
                          };
                          context.read<TeacherViewGroupBloc>().add(MarkAttendanceEvent(attendanceRecord: record));
                        },
                        studentName: state.groupMembersList[index].studentFullName ?? "",
                      );
                    },
                  )),
                  Gaps.verticalGap(value: 10),
                  TutrPrimaryButton(
                      onPressed: () {
                        context.read<TeacherViewGroupBloc>().add(SaveStudensAttendanceEvent(
                            context: context,
                            groupId: widget.takeAttendanceArgs.groupId,
                            markedAttendanceList: state.markedAttendanceList,
                            remarks: remarksController.text));
                      },
                      label: state.saveAttendanceLoading ? "Marking Attendance..." : "Save"),
                  Gaps.verticalGap(value: 10)
                ],
              );
            } else {
              return Center(
                child: Text(
                  "No student found in this group.",
                  style: CustomTextStyles.errorTextStyle,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
