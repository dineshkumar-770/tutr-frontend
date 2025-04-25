// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/models/arguments/upload_notes_study_material_args.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';

class UploadNotesScreen extends StatefulWidget {
  const UploadNotesScreen({
    super.key,
    required this.uploadNotesStudyMaterialArgs,
  });
  final UploadNotesStudyMaterialArgs uploadNotesStudyMaterialArgs;

  @override
  State<UploadNotesScreen> createState() => _UploadNotesScreenState();
}

class _UploadNotesScreenState extends State<UploadNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Upload Class Material",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 6,
                      maxWidth: double.maxFinite,
                      minWidth: double.maxFinite,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.grey,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        spacing: 12,
                        children: [
                          CustomTextField(
                              label: "Material Title", hint: "Enter class material title", controller: titleController),
                          CustomTextField(
                              label: "Material Description",
                              hint: "Enter class material description",
                              controller: descController),
                          CustomTextField(
                              label: "Material Subject",
                              hint: "Enter class material description",
                              controller: subjectController),
                          CustomTextField(
                              label: "Material Topic", hint: "Enter class material topic", controller: topicController),
                          if (state.attachedFilePathsList.isNotEmpty) ...[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                spacing: 8,
                                children: List.generate(
                                  state.attachedFilePathsList.length,
                                  (index) {
                                    return previewSelectMedia(
                                      path: state.attachedFilePathsList[index],
                                      onClose: () {
                                        context.read<TeacherViewGroupBloc>().add(UpdateAttachmentsEvent(
                                            selectedFilePath: state.attachedFilePathsList[index]));
                                      },
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                          GestureDetector(
                            onTap: () {
                              context.read<TeacherViewGroupBloc>().add(AttachClassMaterialEvent(context: context));
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
                                      FontAwesomeIcons.file,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    Text(
                                      state.attachedFilePathsList.isNotEmpty ? "Attach More" : "Attach Media",
                                      style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "*Note: Kindly rename the file by your own before uploading, for better experience.",
                            style: TextStyle(color: AppColors.primaryColor, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: TutrPrimaryButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      descController.text.isNotEmpty &&
                      topicController.text.isNotEmpty) {
                    if (state.attachedFilePathsList.isNotEmpty) {
                      context.read<TeacherViewGroupBloc>().add(UploadGroupMaterialEvent(
                          notesTitle: titleController.text,
                          notesDescription: descController.text,
                          className: widget.uploadNotesStudyMaterialArgs.className,
                          notesTopic: topicController.text,
                          subject: subjectController.text,
                          visiblity: "private",
                          groupId: widget.uploadNotesStudyMaterialArgs.groupId,
                          isEditable: "true",
                          context: context,
                          filePath: state.attachedFilePathsList));
                    } else {
                      CustomToast.show(
                          toastType: ToastificationType.warning,
                          context: context,
                          title: "To save study material, please attach atleast one file!");
                    }
                  } else {
                    CustomToast.show(
                        toastType: ToastificationType.warning,
                        context: context,
                        title: "To save study material, all fields are required!");
                  }
                },
                label: state.uploadNotesLoading ? "Uploading..." : "Upload"),
          );
        },
      ),
    );
  }

  Widget uploadMediaWidget(
      {required String title, required IconData icon, required void Function()? onTap, required BuildContext context}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
            border: Border.all(
              width: 0.4,
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primaryColor,
            boxShadow: [
              BoxShadow(blurRadius: 3, blurStyle: BlurStyle.outer, spreadRadius: 0, color: AppColors.primaryColor)
            ]),
        child: Center(
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AppColors.white,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget previewSelectMedia({required String path, required void Function()? onClose}) {
    bool isImageAttached = path.split("/").last.contains("jpeg") ||
        path.split("/").last.contains("png") ||
        path.split("/").last.contains("jpg");
    bool isPdfAttached = path.split("/").last.contains("pdf");
    return Container(
      height: 150,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: AppColors.black), borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          if (isImageAttached && !isPdfAttached) ...[
            Align(
              alignment: Alignment.center,
              child: Image(
                image: FileImage(File(path)),
                height: 130,
                width: 80,
                fit: BoxFit.fill,
              ),
            ),
          ],
          if (isPdfAttached && !isImageAttached) ...[
            Align(
                alignment: Alignment.center,
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.filePdf,
                    color: AppColors.red,
                    size: 40,
                  ),
                ))
          ],
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: onClose,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.red,
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
