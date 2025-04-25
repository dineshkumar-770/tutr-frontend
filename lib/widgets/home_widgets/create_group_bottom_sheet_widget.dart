// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tutr_frontend/core/common/custom_textfield.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/themes/styles/drop_down_style.dart';
import 'package:tutr_frontend/viewmodels/home_bloc/bloc/home_screen_bloc.dart';

class CreateGroupBottomSheetWidget extends StatelessWidget {
  const CreateGroupBottomSheetWidget({
    super.key,
    required this.onPressed,
    required this.groupNameController,
    required this.groupDescontroller,
  });
  final void Function() onPressed;
  final TextEditingController groupNameController;
  final TextEditingController groupDescontroller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(
                      "Select Class",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    if (state.userProfileLoading) ...[
                      DropdownButtonFormField<String>(
                        decoration: DropDownStyle.getDropDownDecoration(),
                        hint: Text("Getting your classes..."),
                        items: null,
                        onChanged: null,
                      )
                    ] else if (state.userProfileError.isNotEmpty) ...[
                      DropdownButtonFormField<String>(
                        decoration: DropDownStyle.getDropDownDecoration(),
                        hint: Text(state.userProfileError),
                        items: null,
                        onChanged: null,
                      )
                    ] else if (state.teacherData.response?.classAssigned != null) ...[
                      DropdownButtonFormField<String>(
                        decoration: DropDownStyle.getDropDownDecoration(),
                        hint: Text("Select your class for group"),
                        items: (state.teacherData.response!.classAssigned!.split(","))
                            .map(
                              (cls) => DropdownMenuItem<String>(value: cls, child: Text(cls)),
                            )
                            .toList(),
                        onChanged: (value) {
                          log(value.toString());
                          context.read<HomeScreenBloc>().add(SelectClassForGroupcreationEvent(value: value.toString()));
                        },
                      )
                    ] else ...[
                      SizedBox.shrink()
                    ],
                    CustomTextField(
                      label: "Group Name",
                      hint: "Enter name of your group",
                      controller: groupNameController,
                    ),
                    CustomTextField(
                      label: "Group Description",
                      hint: "Enter description for your group",
                      maxLines: 3,
                      maxLength: 100,
                      controller: groupDescontroller,
                    ),
                  ],
                ),
              ));
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: TutrPrimaryButton(
          onPressed: onPressed,
          //  () {
            // if (state.selectedClass == "" || groupDescontroller.text.isEmpty || groupNameController.text.isEmpty) {
            //   CustomToast.show(
            //       toastType: ToastificationType.warning,
            //       context: context,
            //       title: "All Fields are required to create the group!");
            // } else {
            //   context.read<HomeScreenBloc>().add(CreateGroupEvent(
            //       groupClass: state.selectedClass,
            //       groupDescription: groupDescontroller.text,
            //       groupTitle: groupNameController.text,
            //       context: context));
            // }
          // },
          label: "Create",
        ),
      ),
    );
  }
}
