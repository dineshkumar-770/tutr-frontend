// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/app_popups.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/models/arguments/doubts_post_arguments.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';

class PostingDoubtChatWidget extends StatelessWidget {
  const PostingDoubtChatWidget({
    super.key,
    required this.doubtTextController,
    required this.doubtsPostArguments,
  });
  final TextEditingController doubtTextController;
  final DoubtsPostArguments doubtsPostArguments;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
      builder: (context, state) {
        return Row(
          children: [
            GestureDetector(
              onTapDown: (details) {
                final RenderBox renderBox = context.findRenderObject() as RenderBox;
                final Offset globalPosition = renderBox.localToGlobal(details.localPosition);
                locatorDI<AppPopups>()
                    .showAttachmentsPopUp(
                  context: context,
                  position: globalPosition,
                )
                    .then(
                  (value) {
                    if (value != null) {
                      if (value == "1") {
                        if (context.mounted) {
                          context.read<TeacherViewGroupBloc>().add(AttachDoubtPostMaterial(context: context, fileType: "pdf"));
                        }
                      } else if (value == "2") {
                        if (context.mounted) {
                          context.read<TeacherViewGroupBloc>().add(AttachDoubtPostMaterial(context: context, fileType: "jpg"));
                        }
                      }
                    }
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.attach_file, color: AppColors.black),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: AppColors.grey200, borderRadius: BorderRadius.circular(28)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: 5,
                        controller: doubtTextController,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryColor,
              child: IconButton(
                icon: state.postDoubtLoading
                    ? CustomLoadingWidget(
                        color: AppColors.white,
                      )
                    : Icon(Icons.send, color: AppColors.white),
                onPressed: state.postDoubtLoading
                    ? null
                    : () {
                        context.read<TeacherViewGroupBloc>().add(PostDoubtInFeedEvent(
                            context: context,
                            doubtText: doubtTextController.text,
                            filePath: state.attachedDoubtFiles,
                            groupId: doubtsPostArguments.groupId,
                            studentId: Prefs.getString(ConstantStrings.userId),
                            teacherId: doubtsPostArguments.teacherId));
                      },
              ),
            ),
          ],
        );
      },
    );
  }
}
