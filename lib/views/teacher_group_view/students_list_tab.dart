// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/invite_memeber_args.dart';
import 'package:tutr_frontend/models/arguments/studnets_list_args.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/group_member_card.dart';
import 'package:tutr_frontend/widgets/teacher_view/teacher_view_group_popups.dart';

class StudentsListTab extends StatefulWidget {
  const StudentsListTab({
    super.key,
    required this.studnetsListArgs,
  });
  final StudnetsListArgs studnetsListArgs;

  @override
  State<StudentsListTab> createState() => _StudentsListTabState();
}

class _StudentsListTabState extends State<StudentsListTab> {
  TeacherViewGroupPopups teacherViewGroupPopups = TeacherViewGroupPopups();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "My Students",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
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
                if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        context.read<TeacherViewGroupBloc>().add(FetchuserContactsListEvent(context: context));
                        Navigator.pushNamed(context, AppRouteNames.inviteStudentScreen,
                            arguments: InviteStudentScreenArgs(
                              className: widget.studnetsListArgs.className,
                              groupId: widget.studnetsListArgs.groupId,
                              teacherName: widget.studnetsListArgs.teacherName,
                            ));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.4,
                              color: AppColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(200),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: 0,
                                  color: AppColors.primaryColor)
                            ]),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              Text(
                                "Invite Student",
                                style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<TeacherViewGroupBloc>().add(FetchGroupMembersEvent(
                          context: context,
                          groupId: widget.studnetsListArgs.groupId,
                          ownerId: widget.studnetsListArgs.teacherId));
                    },
                    child: ListView.builder(
                      itemCount: state.groupMembersList.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GroupMemberCard(
                          member: state.groupMembersList[index],
                          onTap: (details) async {
                            final value = await teacherViewGroupPopups.showPopUpMenu(
                                context: context, position: details.globalPosition, tileWidth: double.maxFinite);
                            log(value.toString());
                          },
                        );
                      },
                    ),
                  ),
                ),
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
    );
  }
}
