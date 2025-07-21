import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';

class PostingDoubtAttachmentWidget extends StatelessWidget {
  const PostingDoubtAttachmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
      builder: (context, state) {
        return ClipRRect(
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
        );
      },
    );
  }
}
