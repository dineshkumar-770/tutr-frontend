// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/teacher_view_group_popups.dart';

class NoticeBoardTab extends StatefulWidget {
  const NoticeBoardTab({
    super.key,
    required this.groupId,
  });
  final String groupId;

  @override
  State<NoticeBoardTab> createState() => _NoticeBoardTabState();
}

class _NoticeBoardTabState extends State<NoticeBoardTab> {
  TeacherViewGroupPopups teacherViewGroupPopups = TeacherViewGroupPopups();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Notice Board",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50,
                  child: Lottie.asset("assets/lotties/notice_anoucement.json", repeat: false),
                ),
                Text(
                  "Speak Your Board",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Gaps.verticalGap(value: 4),
            Text(
              "*This is your notice board. First, add a title, then describe your notice. Your message will be visible to all students in this group.",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Gaps.verticalGap(value: 20),
            BlocConsumer<TeacherViewGroupBloc, TeacherViewGroupState>(
              listener: (context, state) {},
              builder: (context, state) {
                log("BlocBuilder rebuilding...");
                log("Loading: ${state.fetchNoticeLoading}");
                log("Error: ${state.fetchNoticError}");
                log("Notice: ${state.groupNoticeData.response?.title}");
                if (state.fetchNoticeLoading) {
                  return Center(
                    child: CustomLoadingWidget(),
                  );
                } else if (state.fetchNoticError.isNotEmpty) {
                  return Center(
                    child: Text(
                      state.fetchNoticError,
                      style: CustomTextStyles.errorTextStyle,
                    ),
                  );
                } else if (state.groupNoticeData.response != null) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: double.maxFinite,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              blurRadius: 3, blurStyle: BlurStyle.outer, spreadRadius: 3, color: AppColors.black26)
                        ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                state.groupNoticeData.response?.title ?? "No Alerts Yet!",
                                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor2),
                              ),
                            ),
                            Divider(
                              endIndent: 16,
                              indent: 16,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    child: Text(
                                      state.groupNoticeData.response?.description ?? "Annoucement on the way...",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(color: AppColors.textColor2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Last Updated: ${DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.fromMillisecondsSinceEpoch((state.groupNoticeData.response?.updatedAt ?? 0) * 1000))}",
                                style:
                                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            if (Prefs.getString(ConstantStrings.userType) == ConstantStrings.teacher) ...[
              Spacer(),
              BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
                builder: (context, state) {
                  return TutrPrimaryButton(
                      onPressed: () async {
                        if (state.groupNoticeData.response != null) {
                          titleController.text = state.groupNoticeData.response?.title ?? "";
                          descController.text = state.groupNoticeData.response?.description ?? "";
                        }
                        final canCreateNotice = await teacherViewGroupPopups.showNameReportPop(
                            context: context,
                            titleController: titleController,
                            descController: descController,
                            titleString:
                                state.groupNoticeData.response != null ? "Update Notice Board" : "Create Notice Board");

                        log(canCreateNotice.toString());

                        if (canCreateNotice ?? false) {
                          if (context.mounted) {
                            if (state.groupNoticeData.response == null) {
                              context.read<TeacherViewGroupBloc>().add(CreateNoticeForGroupEvent(
                                  context: context,
                                  description: descController.text,
                                  groupId: widget.groupId,
                                  title: titleController.text));
                            } else {
                              if (state.groupNoticeData.response?.noticeId != null) {
                                context.read<TeacherViewGroupBloc>().add(UpdateNoticeBoardEvent(
                                      context: context,
                                      groupId: widget.groupId,
                                      noticeDesc: descController.text,
                                      noticeTitle: titleController.text,
                                      noticeId: state.groupNoticeData.response?.noticeId ?? "",
                                    ));
                              } else {
                                CustomToast.show(
                                    toastType: ToastificationType.error,
                                    context: context,
                                    title:
                                        "It seems your notice board data has not been registered with or May be some technical error occured!");
                              }
                            }
                          }
                        }
                      },
                      label: state.groupNoticeData.response != null ? "Update Notice Board" : "Create Notice Board");
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
