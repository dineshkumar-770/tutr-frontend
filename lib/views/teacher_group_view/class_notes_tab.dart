// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/app_popups.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/models/arguments/class_material_args.dart';
import 'package:tutr_frontend/models/arguments/preview_notes_args.dart';
import 'package:tutr_frontend/models/arguments/upload_notes_study_material_args.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/teacher_view_group_bloc/bloc/teacher_view_group_bloc.dart';
import 'package:tutr_frontend/widgets/teacher_view/teacher_view_group_popups.dart';

class ClassNotesTab extends StatefulWidget {
  const ClassNotesTab({
    super.key,
    required this.classMaterialArgs,
  });
  final ClassMaterialArgs classMaterialArgs;

  @override
  State<ClassNotesTab> createState() => _ClassNotesTabState();
}

class _ClassNotesTabState extends State<ClassNotesTab> {
  final helpers = locatorDI<Helper>();
  TeacherViewGroupPopups teacherViewGroupPopups = TeacherViewGroupPopups();
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Class Material",
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyles.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) ...[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRouteNames.uploadNotesScreen,
                      arguments: UploadNotesStudyMaterialArgs(
                          className: widget.classMaterialArgs.className,
                          groupId: widget.classMaterialArgs.groupId,
                          subject: ""));
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
                            blurRadius: 3, blurStyle: BlurStyle.outer, spreadRadius: 0, color: AppColors.primaryColor)
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
                          "Upload Notes",
                          style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
            Gaps.verticalGap(value: 15),
            BlocBuilder<TeacherViewGroupBloc, TeacherViewGroupState>(
              builder: (context, state) {
                if (state.getGroupNotesLoading) {
                  return Center(
                    child: CustomLoadingWidget(),
                  );
                } else if (state.groupNotesError.isNotEmpty) {
                  return Center(
                    child: Text(
                      state.groupNotesError,
                      style: CustomTextStyles.errorTextStyle,
                    ),
                  );
                } else if ((state.groupNotesMaterialdata.isNotEmpty)) {
                  return Expanded(
                      child: RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<TeacherViewGroupBloc>()
                          .add(FetchGroupMaterialNotes(context: context, groupId: widget.classMaterialArgs.groupId));
                    },
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Gaps.verticalGap(value: 10),
                      itemCount: state.groupNotesMaterialdata.length,
                      itemBuilder: (context, index) {
                        final notes = state.groupNotesMaterialdata[index];
                        return Stack(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                minHeight: MediaQuery.of(context).size.height / 5,
                                maxWidth: double.maxFinite,
                                minWidth: double.maxFinite,
                              ),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Stack(
                                children: [
                                  Container(
                                    //locatorDI<Helper>().getUserType() == ConstantStrings.teacher;
                                    decoration: BoxDecoration(color: Colors.red),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.deleteNotesLoading && state.deleteNotesIndex == index) ...[
                                          LinearProgressIndicator(),
                                        ],
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "${notes.notesTitle ?? ""} (${notes.notesTopic ?? ""})",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.textColor1),
                                                  ),
                                                  Text(
                                                    "• ${notes.notesDesctription ?? ""}",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: AppColors.textColor1.withValues(alpha: 0.75),
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                            if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) ...[
                                              InkWell(
                                                  onTapDown: (position) async {
                                                    final value = await teacherViewGroupPopups.showPopUpMenuNotes(
                                                        context: context,
                                                        position: position.globalPosition,
                                                        tileWidth: double.maxFinite);
                                                    if (value != null) {
                                                      if (context.mounted) {
                                                        locatorDI<AppPopups>().showGeneralInfoPop(
                                                          context: context,
                                                          height: MediaQuery.of(context).size.height / 2,
                                                          title: "Are you sure?",
                                                          actionButtons: [
                                                            TextButton(
                                                                onPressed: () async {
                                                                  Navigator.pop(context);
                                                                  await Future.delayed(
                                                                      const Duration(milliseconds: 200));
                                                                  if (context.mounted) {
                                                                    context.read<TeacherViewGroupBloc>().add(
                                                                        DeleteClassMaterialEvent(
                                                                            context: context,
                                                                            selectedNotesIndex: index,
                                                                            notesId: notes.notesId ?? "",
                                                                            groupId: widget.classMaterialArgs.groupId,
                                                                            notesTitle: notes.notesTitle ?? "",
                                                                            reason: reasonController.text,
                                                                            notesDescription:
                                                                                notes.notesDesctription ?? "",
                                                                            filesUrl:
                                                                                notes.attachedFiles?.join(",") ?? ""));
                                                                  }
                                                                },
                                                                child: const Text("Yes")),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: const Text("No"))
                                                          ],
                                                          content: [
                                                            Icon(
                                                              Icons.info,
                                                              color: AppColors.amber,
                                                              size: 80,
                                                            ),
                                                            Gaps.verticalGap(value: 10),
                                                            Text(
                                                              "Are you certain you want to delete these notes? Once deleted, you will need to upload them again manually.",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(color: AppColors.textColor2),
                                                            ),
                                                            Gaps.verticalGap(value: 15),
                                                            CustomTextField(
                                                                label: "Reason",
                                                                maxLines: 2,
                                                                hint: "Any reason why delete?",
                                                                controller: reasonController)
                                                          ],
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: Icon(Icons.more_vert))
                                            ],
                                          ],
                                        ),
                                        Gaps.verticalGap(value: 10),
                                        GestureDetector(
                                          onTap: state.groupNotesMaterialdata[index].notesVisiblity ==
                                                      ConstantStrings.private &&
                                                  locatorDI<Helper>().getUserType() == ConstantStrings.student
                                              ? null
                                              : () {
                                                  Navigator.pushNamed(context, AppRouteNames.previewNotesScreen,
                                                      arguments: PreviewNotesArgs(
                                                          notesURL:
                                                              state.groupNotesMaterialdata[index].attachedFiles ?? []));
                                                },
                                          child: state.groupNotesMaterialdata[index].notesVisiblity ==
                                                      ConstantStrings.private &&
                                                  locatorDI<Helper>().getUserType() == ConstantStrings.student
                                              ? ListTile(
                                                  leading: Icon(
                                                    Icons.private_connectivity,
                                                    size: 60,
                                                  ),
                                                  title: Text(
                                                    "This Study Material is marked private by your Teacher.",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors.textColor2,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                )
                                              : SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  physics: const BouncingScrollPhysics(),
                                                  child: Row(
                                                    spacing: 10,
                                                    children: List.generate(
                                                      state.groupNotesMaterialdata[index].attachedFiles?.length ?? 0,
                                                      (fileIndex) {
                                                        return Container(
                                                          height: 100,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              border:
                                                                  Border.all(width: 1, color: AppColors.primaryColor),
                                                              borderRadius: BorderRadius.circular(8)),
                                                          child: Stack(
                                                            children: [
                                                              if (helpers.isImage(
                                                                  notes.attachedFiles?[fileIndex].noteUrl ?? "")) ...[
                                                                Align(
                                                                  alignment: Alignment.center,
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        image: DecorationImage(
                                                                            image: NetworkImage(notes
                                                                                    .attachedFiles?[fileIndex]
                                                                                    .noteUrl ??
                                                                                ""),
                                                                            fit: BoxFit.fill)),
                                                                  ),
                                                                ),
                                                              ],
                                                              if (helpers.isPdf(
                                                                  notes.attachedFiles?[fileIndex].noteUrl ?? "")) ...[
                                                                Align(
                                                                    alignment: Alignment.center,
                                                                    child: Center(
                                                                      child: Icon(
                                                                        FontAwesomeIcons.filePdf,
                                                                        color: AppColors.red,
                                                                        size: 40,
                                                                      ),
                                                                    ))
                                                              ]
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        Gaps.verticalGap(value: 10),
                                        Text(
                                          "Updated At: ${helpers.formatTimeFronUnixTimeStamp(notes.uploadedAt ?? 0)}",
                                          style: TextStyle(
                                              color: AppColors.textColor1.withValues(alpha: 0.75),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        locatorDI<Helper>().getUserType() == ConstantStrings.teacher
                            ? "No study material found for this group\nGo ahead and create the study material"
                            : "No study material found for this group\nAsk your teacher to add study material or Notes to show them here",
                        style: CustomTextStyles.errorTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
