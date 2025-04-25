// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/invite_memeber_args.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';

class InviteStudentScreen extends StatefulWidget {
  const InviteStudentScreen({
    super.key,
    required this.inviteStudentScreenArgs,
  });
  final InviteStudentScreenArgs inviteStudentScreenArgs;

  @override
  State<InviteStudentScreen> createState() => _InviteStudentScreenState();
}

class _InviteStudentScreenState extends State<InviteStudentScreen> {
  TextEditingController searchContactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Invite Student",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
        builder: (context, state) {
          if (state.fetchUserConatcsLoading) {
            return Center(
              child: CustomLoadingWidget(),
            );
          } else {
            if (state.userContactsData.isNotEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                              label: "Invite", hint: "Invite For New Contact", controller: searchContactController),
                        ),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                if (searchContactController.text.isNotEmpty &&
                                    searchContactController.text.length == 10) {
                                  context.read<TeacherViewGroupBloc>().add(CheckBeforeInviteStudentEvent(
                                        tappedIndex: -1,
                                        context: context,
                                        phoneNumber: searchContactController.text,
                                        className: widget.inviteStudentScreenArgs.className,
                                        groupId: widget.inviteStudentScreenArgs.groupId,
                                        ownerName: widget.inviteStudentScreenArgs.teacherName,
                                      ));
                                } else {
                                  CustomToast.show(
                                      toastType: ToastificationType.warning,
                                      context: context,
                                      title: "Invalid Mobile Number Format");
                                }
                              },
                              icon: Icon(FontAwesomeIcons.search)),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                    color: AppColors.textColor1,
                  ),
                  Text(
                    "Or Invite from your contact list",
                    style: TextStyle(color: AppColors.textColor1, fontWeight: FontWeight.bold, wordSpacing: 5),
                  ),
                  Expanded(
                    child: AzListView(
                      data: state.userContactsData,
                      hapticFeedback: true,
                      itemCount: state.userContactsData.length,
                      indexBarItemHeight: 20,
                      itemBuilder: (context, index) {
                        return locatorDI<Helper>()
                                .sanitizePhoneNumberList(state.userContactsData[index].phoneNumber)
                                .isEmpty
                            ? SizedBox.shrink()
                            : Stack(
                                children: [
                                  ListTile(
                                      leading: state.userContactsData[index].profilePic != null
                                          ? CircleAvatar(
                                              backgroundColor: AppColors.primaryColor,
                                              radius: 25,
                                              backgroundImage: MemoryImage(state.userContactsData[index].profilePic!),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: AppColors.primaryColor,
                                              radius: 25,
                                              child: Center(
                                                child: Text(
                                                  state.userContactsData[index].name[0].toUpperCase(),
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w300),
                                                ),
                                              ),
                                            ),
                                      isThreeLine: true,
                                      title: Text(
                                        state.userContactsData[index].name,
                                        style: TextStyle(
                                            color: AppColors.textColor1, fontSize: 18, fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Gaps.verticalGap(value: 6),
                                          Text(
                                            "Tap phone to invite",
                                            style: TextStyle(
                                                color: AppColors.textColor1, fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                          Gaps.verticalGap(value: 3),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              spacing: 10,
                                              children: List.generate(
                                                locatorDI<Helper>()
                                                    .sanitizePhoneNumberList(state.userContactsData[index].phoneNumber)
                                                    .length,
                                                (index2) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      context.read<TeacherViewGroupBloc>().add(
                                                          CheckBeforeInviteStudentEvent(
                                                              context: context,
                                                              tappedIndex: index,
                                                              className: widget.inviteStudentScreenArgs.className,
                                                              groupId: widget.inviteStudentScreenArgs.groupId,
                                                              ownerName: widget.inviteStudentScreenArgs.teacherName,
                                                              phoneNumber: locatorDI<Helper>().sanitizePhoneNumberList(
                                                                  state.userContactsData[index].phoneNumber)[index2]));
                                                    },
                                                    child: Chip(
                                                      shape: StadiumBorder(
                                                        side: BorderSide(color: AppColors.primaryColor, width: 1),
                                                      ),
                                                      backgroundColor: Colors.transparent,
                                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                      labelPadding: EdgeInsets.zero,
                                                      visualDensity: VisualDensity.compact,
                                                      label: Text(
                                                        locatorDI<Helper>().sanitizePhoneNumberList(
                                                            state.userContactsData[index].phoneNumber)[index2],
                                                        style: TextStyle(
                                                          color: AppColors.textColor1,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  state.checkStudentInviteLoading && index == state.inviteTappedIndex
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey.withValues(alpha: 0.75),
                                            ),
                                            child: Center(
                                              child: CustomLoadingWidget(),
                                            ),
                                          ))
                                      : SizedBox.shrink()
                                ],
                              );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  "No contacts found!",
                  style: CustomTextStyles.errorTextStyle,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
