// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/models/arguments/doubts_post_arguments.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/doubt_screen_widgets/doubt_post_card.dart';
import 'package:tutr_frontend/widgets/doubt_screen_widgets/posting_doubt_attachment_widget.dart';
import 'package:tutr_frontend/widgets/doubt_screen_widgets/posting_doubt_chat_widget.dart';

class DoubtsChatTab extends StatefulWidget {
  const DoubtsChatTab({
    super.key,
    required this.doubtsPostArguments,
  });
  final DoubtsPostArguments doubtsPostArguments;

  @override
  State<DoubtsChatTab> createState() => _DoubtsChatTabState();
}

class _DoubtsChatTabState extends State<DoubtsChatTab> {
  TextEditingController chatTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Student Doubts Feed",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
        builder: (context, state) {
          if (state.doubtPostsLoading) {
            return Center(
              child: CustomLoadingWidget(),
            );
          } else if (state.doubtPostsGetError.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      Prefs.getString(ConstantStrings.userId).contains(ConstantStrings.student)
                          ? state.doubtPostsGetError
                          : "No doubts have been posted by your students yet. You may encourage them to share their queries.",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.errorTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TutrPrimaryButton(
                        onPressed: () {
                          context
                              .read<TeacherViewGroupBloc>()
                              .add(GetDoubtPostsEvent(groupId: widget.doubtsPostArguments.groupId, teacherId: widget.doubtsPostArguments.teacherId));
                        },
                        label: "Try Again"),
                  ),
                  Spacer(),
                  if (Prefs.getString(ConstantStrings.userId).contains(ConstantStrings.student)) ...[
                    if (state.attachedDoubtFiles.isNotEmpty) ...[
                      Positioned(
                          bottom: 70, // Adjust based on your layout
                          left: 12,
                          right: 12,
                          child: PostingDoubtAttachmentWidget()),
                    ],
                    Positioned(
                        bottom: 10,
                        left: 8,
                        right: 8,
                        child: PostingDoubtChatWidget(
                          doubtTextController: chatTextController,
                          doubtsPostArguments: widget.doubtsPostArguments,
                        )),
                  ]
                ],
              ),
            );
          } else {
            if (state.doubtPostsData.isNotEmpty) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Gaps.verticalGap(value: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(200)),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Center(
                                child: Text("All", style: TextStyle(color: AppColors.textColor1, fontSize: 16, fontWeight: FontWeight.w400)),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(200)),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Center(
                                child: Text("Solved", style: TextStyle(color: AppColors.textColor1, fontSize: 16, fontWeight: FontWeight.w400)),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(200)),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Center(
                                child: Text("Unsolved", style: TextStyle(color: AppColors.textColor1, fontSize: 16, fontWeight: FontWeight.w400)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.verticalGap(value: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.doubtPostsData.length,
                          itemBuilder: (context, index) => DoubtPostCard(doubt: state.doubtPostsData[index]),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width / 6), // Leave space for blur container
                    ],
                  ),
                  if (Prefs.getString(ConstantStrings.userId).contains(ConstantStrings.student)) ...[
                    if (state.attachedDoubtFiles.isNotEmpty) ...[
                      Positioned(
                          bottom: 70, // Adjust based on your layout
                          left: 12,
                          right: 12,
                          child: PostingDoubtAttachmentWidget()),
                    ],
                    
                    Positioned(
                        bottom: 10,
                        left: 8,
                        right: 8,
                        child: PostingDoubtChatWidget(
                          doubtTextController: chatTextController,
                          doubtsPostArguments: widget.doubtsPostArguments,
                        )),
                  ]
                ],
              );
            } else {
              return Center(
                child: Text(
                  "None doubts has been posted yet!",
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
