import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/repository/api_endpoints.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/models/arguments/student_id_card_args.dart';
import 'package:tutr_frontend/models/arguments/teacher_id_args.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/utils/helpers.dart';
import 'package:tutr_frontend/viewmodels/home_bloc/bloc/home_screen_bloc.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Profile Settings"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state.userProfileLoading) {
            return Center(
              child: CustomLoadingWidget(),
            );
          } else if (state.userProfileError.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.userProfileError,
                    style: CustomTextStyles.errorTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TutrPrimaryButton(
                        onPressed: () async {
                          await Prefs.clear();
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRouteNames.splashScreen,
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                        label: "logout"),
                  )
                ],
              ),
            );
          } else {
            return Column(
              spacing: 8,
              children: [
                InkWell(
                  onTap: () {
                    if (locatorDI<Helper>().getUserType() == ConstantStrings.student) {
                      Navigator.pushNamed(context, AppRouteNames.studentIdCardScreen,
                          arguments: StudentIdCardArgs(
                              name: state.studentProfileData.response?.fullName ?? "",
                              id: state.studentProfileData.response?.studentId ?? "",
                              parentsContact: state.studentProfileData.response?.parentsContact.toString() ?? "",
                              phone: state.studentProfileData.response?.contactNumber.toString() ?? "",
                              email: state.studentProfileData.response?.email ?? "",
                              address: state.studentProfileData.response?.fullAddress ?? "",
                              className: state.studentProfileData.response?.responseClass ?? "",
                              joinedAt: state.studentProfileData.response?.createdAt ?? 0,
                              imageUrl: ""));
                    } else if (locatorDI<Helper>().getUserType() == ConstantStrings.teacher) {
                      Navigator.pushNamed(context, AppRouteNames.teacherIDCardScreen,
                          arguments: TeacherIdArgs(
                              address: state.teacherData.response?.address ?? "",
                              email: state.teacherData.response?.email ?? "",
                              experienceYears: state.teacherData.response?.experienceYears?.toString() ?? "",
                              id: state.teacherData.response?.teacherId ?? "",
                              joinedAt: state.teacherData.response?.createdAt ?? 0,
                              imageUrl: "",
                              name: state.teacherData.response?.fullName ?? "",
                              phone: state.teacherData.response?.contactNumber.toString() ?? "",
                              qualifications: state.teacherData.response?.qualification ?? ""));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
                        BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer, spreadRadius: 1, color: AppColors.grey)
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("My ID Card"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
                      BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer, spreadRadius: 1, color: AppColors.grey)
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dark Mode"),
                          Switch.adaptive(
                            value: false,
                            onChanged: (value) {},
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
                      BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer, spreadRadius: 1, color: AppColors.grey)
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Build"),
                          Text(state.packageInfo.buildNumber),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
                      BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer, spreadRadius: 1, color: AppColors.grey)
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("App Version"),
                          Text("${state.packageInfo.version}(${ApiEndpoints.serverName})"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TutrPrimaryButton(
                    onPressed: () async {
                      await Prefs.clear();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouteNames.splashScreen,
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    label: "logout")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
