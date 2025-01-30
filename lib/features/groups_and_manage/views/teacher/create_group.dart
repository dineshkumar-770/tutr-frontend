import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutr/common/custom_appbar.dart';
import 'package:tutr/common/custom_button.dart';
import 'package:tutr/common/custom_loading_widget.dart';
import 'package:tutr/common/custom_message_widget.dart';
import 'package:tutr/common/custom_textfield.dart';
import 'package:tutr/features/groups_and_manage/controller/group_manage_controller.dart';
import 'package:tutr/resources/app_colors.dart';
import 'package:tutr/resources/text_styles.dart';

class CreateGroup extends ConsumerWidget {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createGpState = ref.watch(groupManageNotifierProvider);
    final providerFunc = ref.read(groupManageNotifierProvider.notifier);
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        title: "",
        useWidgetOnTitle: true,
        leadingWidget: SizedBox(),
        centerTitle: true,
        titleWidget: Text(
          "Create Group",
          style: TextStyle(fontSize: 16, color: AppColors.textColor1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          spacing: 15,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Class",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: 'InterTight',
                        fontSize: 12,
                      ),
                ),
                DropdownButtonFormField<String>(
                  decoration: CustomTextStylesAndDecorations.getDropDownDecoration(),
                  value: createGpState.selectedClass,
                  items: createGpState.listOfClasses
                      .map(
                        (cls) => DropdownMenuItem<String>(value: cls, child: Text(cls)),
                      )
                      .toList(),
                  onChanged: (value) {
                    providerFunc.selectClassroom(value.toString());
                  },
                ),
              ],
            ),
            CustomTextField(
              label: "Group Title",
              hint: "What should the title of your group?",
              controller: providerFunc.groupTitle,
            ),
            CustomTextField(
              label: "Group Description",
              hint: "What should the description of your group?",
              controller: providerFunc.groupDescription,
            ),
            Spacer(),
            CustomButton(
                onTap: () async {
                  if (providerFunc.groupTitle.text.isEmpty || providerFunc.groupTitle.text.length < 5) {
                    CustomSnackbar.show(
                        context: context,
                        message: "Group title cannot be empty and word length shoul be more than 5",
                        isSuccess: false);
                  } else if (providerFunc.groupDescription.text.isEmpty || providerFunc.groupDescription.text.length < 5) {
                    CustomSnackbar.show(
                        context: context,
                        message: "Group description cannot be empty and word length shoul be more than 5",
                        isSuccess: false);
                  } else {
                    await providerFunc.createTeachersGroups(
                        className: createGpState.selectedClass,
                        groupTitle: providerFunc.groupTitle.text,
                        groupDescription: providerFunc.groupDescription.text,
                        context: context);
                  }
                },
                label: createGpState.createGroupLoading
                    ? CustomLoadingWidget()
                    : Text(
                        "Create",
                        style: CustomTextStylesAndDecorations.primaryButtonTextStyle(),
                      ))
          ],
        ),
      ),
    );
  }
}
