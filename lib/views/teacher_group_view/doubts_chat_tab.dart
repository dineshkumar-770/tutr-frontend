// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/app_popups.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/doubts_post_arguments.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/doubt_screen_widgets/doubt_post_card.dart';

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
  final apppopup = locatorDI<AppPopups>();
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
            return Center(
              child: Text(
                state.doubtPostsGetError,
                style: CustomTextStyles.errorTextStyle,
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
                  if (state.attachedDoubtFiles.isNotEmpty) ...[
                    Positioned(
                      bottom: 70, // Adjust based on your layout
                      left: 12,
                      right: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                              height: MediaQuery.of(context).size.width / 3,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.black26.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                              ),
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    state.attachedDoubtFiles.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Stack(
                                        fit: StackFit.loose,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: locatorDI<Helper>().isImage(state.attachedDoubtFiles[index])
                                                ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image(
                                                      width: 120,
                                                      height: 120,
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          width: 120,
                                                          height: 120,
                                                          decoration: BoxDecoration(
                                                            color: AppColors.grey200,
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                          child: Icon(
                                                            Icons.error_outline,
                                                            color: AppColors.red,
                                                            size: 40,
                                                          ),
                                                        );
                                                      },
                                                      image: FileImage(
                                                        File(state.attachedDoubtFiles[index]),
                                                      ),
                                                    ),
                                                  )
                                                : locatorDI<Helper>().isPdf(state.attachedDoubtFiles[index])
                                                    ? Padding(
                                                        padding: const EdgeInsets.only(right: 8),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(12),
                                                          child: Container(
                                                            width: 120,
                                                            height: 120,
                                                            decoration: BoxDecoration(
                                                              color: AppColors.grey200,
                                                              borderRadius: BorderRadius.circular(12),
                                                            ),
                                                            child: Center(
                                                                child: Icon(
                                                              FontAwesomeIcons.filePdf,
                                                              color: AppColors.red,
                                                            )),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  context.read<TeacherViewGroupBloc>().add(RemoveDoubtPostFileEvent(state.attachedDoubtFiles[index]));
                                                },
                                                child: Icon(
                                                  Icons.close_sharp,
                                                  color: AppColors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                  Positioned(
                    bottom: 10,
                    left: 8,
                    right: 8,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTapDown: (details) {
                            final RenderBox renderBox = context.findRenderObject() as RenderBox;
                            final Offset globalPosition = renderBox.localToGlobal(details.localPosition);
                            apppopup
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
                            icon: Icon(Icons.send, color: AppColors.white),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
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
