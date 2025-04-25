import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/gap.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/themes/styles/drop_down_style.dart';
import 'package:tutr_frontend/utils/custom_extensions.dart';
import 'package:tutr_frontend/viewmodels/auth_bloc/bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.registerType});
  final String registerType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController qualificationController = TextEditingController();
  TextEditingController emailOTPController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentContactController = TextEditingController();
  TextEditingController classRoomController = TextEditingController();
  TextEditingController parentsContactController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController teacherCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Register"),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      CustomTextField(
                        label: "Register Type",
                        hint: "Enter your full name",
                        enable: false,
                        controller: TextEditingController(text: widget.registerType.capitalizeFirst()),
                      ),
                      Gaps.verticalGap(value: 15),
                      CustomTextField(
                        label: "Full Name",
                        hint: "Enter your full name",
                        textInputType: TextInputType.name,
                        controller: fullNameController,
                      ),
                      Gaps.verticalGap(value: 15),
                      CustomTextField(
                        label: "Email",
                        hint: "Enter your email",
                        textInputType: TextInputType.emailAddress,
                        controller: studentEmailController,
                      ),
                      Gaps.verticalGap(value: 15),
                      CustomTextField(
                        label:
                            widget.registerType == ConstantStrings.student ? "Student Phone Number" : "Contact Number",
                        hint: widget.registerType == ConstantStrings.student
                            ? "Enter student's phone number"
                            : "Enter your contact number",
                        textInputType: TextInputType.phone,
                        controller: studentContactController,
                      ),
                      Gaps.verticalGap(value: 15),
                      if (widget.registerType == ConstantStrings.teacher) ...[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How much years of Experience you have?",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "   ${state.selectedExperience.toStringAsFixed(0)} Years   ",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                            Slider.adaptive(
                              value: state.selectedExperience,
                              min: 0,
                              max: 50,
                              divisions: 50,
                              onChanged: (value) {
                                log(value.toString());
                                context.read<AuthBloc>().add(ChooseExperienceEvent(experienceYears: value));
                              },
                            ),
                          ],
                        )
                      ],
                      Gaps.verticalGap(value: 15),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Class",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 14,
                                ),
                          ),
                          if (widget.registerType == ConstantStrings.student) ...[
                            DropdownButtonFormField<String>(
                              decoration: DropDownStyle.getDropDownDecoration(),
                              value: state.selectedClass,
                              items: state.listOfClasses
                                  .map(
                                    (cls) => DropdownMenuItem<String>(value: cls, child: Text(cls)),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                context.read<AuthBloc>().add(RegisterUserCollectInfoEvent(
                                    selectedClass: value.toString(),
                                    selectedClasses: [],
                                    userType: widget.registerType));
                              },
                            ),
                          ],
                          if (widget.registerType == ConstantStrings.teacher) ...[
                            Row(
                              spacing: 15,
                              children: List.generate(state.listOfClasses.length, (index) {
                                final className = state.listOfClasses[index];
                                final isSelected = state.listOfSelectedClasses.contains(className);
                                return GestureDetector(
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                          RegisterUserCollectInfoEvent(
                                            selectedClass: className,
                                            selectedClasses: state.listOfSelectedClasses,
                                            userType: ConstantStrings.teacher,
                                          ),
                                        );
                                  },
                                  child: Chip(
                                    label: Text(state.listOfClasses[index]),
                                    avatar: Icon(
                                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                                    ),
                                    shape: StadiumBorder(),
                                  ),
                                );
                              }),
                            ),
                            Gaps.verticalGap(value: 15),
                            Text(
                              "Select your primary subject",
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                            ),
                            Gaps.verticalGap(value: 5),
                            DropdownButtonFormField<String>(
                              decoration: DropDownStyle.getDropDownDecoration(),
                              value: state.selectedSubject,
                              items: state.listOfSubjects
                                  .map(
                                    (cls) => DropdownMenuItem<String>(value: cls, child: Text(cls)),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                context.read<AuthBloc>().add(ChooseTeacherSubject(selectedSubject: value.toString()));
                              },
                            ),
                          ]
                        ],
                      ),
                      if (widget.registerType == ConstantStrings.teacher) ...[
                        Gaps.verticalGap(value: 15),
                        CustomTextField(
                          label: "Qualification",
                          hint: "Enter your complete qualification",
                          controller: qualificationController,
                        ),
                      ],
                      if (widget.registerType == ConstantStrings.student) ...[
                        Gaps.verticalGap(value: 15),
                        CustomTextField(
                          label: "Parent's Phone Number",
                          hint: "Enter parent's phone number",
                          controller: parentsContactController,
                        ),
                      ],
                      Gaps.verticalGap(value: 15),
                      CustomTextField(
                        label: "Full Address",
                        hint: "Enter your full address",
                        controller: fullAddressController,
                      ),
                      Gaps.verticalGap(value: 15),
                      if (widget.registerType == ConstantStrings.teacher) ...[
                        CustomTextField(
                          label: "Teacher Code",
                          hint: "Enter your desired code",
                          controller: teacherCodeController,
                        ),
                        Gaps.verticalGap(value: 15),
                      ]
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TutrPrimaryButton(
                  label: "Register",
                  onPressed: () {
                    context.read<AuthBloc>().add(RegisterUserEvent(
                        email: studentContactController.text,
                        name: fullNameController.text,
                        personalContect: studentContactController.text,
                        subject: state.selectedSubject,
                        qualifications: qualificationController.text,
                        exprience: state.selectedExperience.toInt(),
                        address: fullAddressController.text,
                        classAssigned: widget.registerType == ConstantStrings.student
                            ? state.selectedClass
                            : state.listOfSelectedClasses.join(","),
                        teacherCode: teacherCodeController.text.toUpperCase(),
                        userType: widget.registerType,
                        parentsContact: parentsContactController.text));
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
