// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutr/common/widgets/custom_appbar.dart';
import 'package:tutr/common/widgets/custom_button.dart';
import 'package:tutr/common/widgets/custom_loading_widget.dart';
import 'package:tutr/common/widgets/custom_textfield.dart';
import 'package:tutr/features/auth/controller/auth_controller.dart';
import 'package:tutr/helpers/extensions.dart';
import 'package:tutr/models/auth_models/all_teachers_model.dart';
import 'package:tutr/common/constants/text_styles.dart';
import 'package:tutr/models/route_arguments/auth_arguments.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({
    super.key,
    required this.registerType,
  });
  final UserAuthType registerType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(authNotifierProvider);
    final providerFunc = ref.read(authNotifierProvider.notifier);
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "Register"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              CustomTextField(
                label: "Register Type",
                hint: "Enter your full name",
                enable: false,
                controller: TextEditingController(text: registerType.authType.capitalizeFirst()),
              ),
              CustomTextField(
                label: "Full Name",
                hint: "Enter your full name",
                textInputType: TextInputType.name,
                controller: providerFunc.fullNameController,
              ),
              CustomTextField(
                label: "Email",
                hint: "Enter your email",
                textInputType: TextInputType.emailAddress,
                controller: providerFunc.studentEmailController,
              ),
              CustomTextField(
                label: "Student Phone Number",
                hint: "Enter student's phone number",
                textInputType: TextInputType.phone,
                controller: providerFunc.studentContactController,
              ),
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
                    value: registerState.selectedClass,
                    items: registerState.listOfClasses
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Teacher and Subject",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: 'InterTight',
                          fontSize: 12,
                        ),
                  ),
                  registerState.getTeachersLoading
                      ? DropdownButtonFormField<String>(
                          decoration: CustomTextStylesAndDecorations.getDropDownDecoration()
                              .copyWith(hintText: "Getting teachers for you..."),
                          value: registerState.selectedClass,
                          items: [],
                          onChanged: null)
                      : DropdownButtonFormField<TeachersData>(
                          decoration: CustomTextStylesAndDecorations.getDropDownDecoration(),
                          value: registerState.selectedTeacher.fullName != null ? registerState.selectedTeacher : null,
                          items: registerState.allTeachersModelData.response
                              .map(
                                (teacher) => DropdownMenuItem<TeachersData>(
                                    value: teacher,
                                    child: Text("${teacher.fullName ?? ""} (${teacher.subject ?? ""})")),
                              )
                              .toList(),
                          onChanged: (value) {
                            providerFunc.selectTeacher(value!);
                          },
                        ),
                ],
              ),
              // CustomTextField(
              //   label: "Teacher Code",
              //   hint: "Enter your teacher's code",
              //   controller: ,
              // ),
              CustomTextField(
                label: "Parent's Phone Number",
                hint: "Enter parent's phone number",
                controller: providerFunc.parentsContactController,
              ),
              CustomTextField(
                label: "Full Address",
                hint: "Enter your full address",
                controller: providerFunc.fullAddressController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          onTap: () {
            providerFunc.registerStudent(
                fullName: providerFunc.fullNameController.text,
                email: providerFunc.studentEmailController.text,
                studentPhoneNumber: providerFunc.studentContactController.text,
                classroom: providerFunc.classRoomController.text,
                teacherCode: registerState.selectedTeacher.teacherCode ?? "",
                parentsPhoneNumber: providerFunc.parentsContactController.text,
                context: context,
                fullAddress: providerFunc.fullAddressController.text);
          },
          label: registerState.registerLoading
              ? CustomLoadingWidget()
              : Text(
                  "Register Me",
                  style: CustomTextStylesAndDecorations.primaryButtonTextStyle(),
                ),
        ),
      ),
    );
  }
}
