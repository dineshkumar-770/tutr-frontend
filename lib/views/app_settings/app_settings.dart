import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/core/common/tutr_button.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/repository/api_endpoints.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
                      BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer, spreadRadius: 1, color: AppColors.grey)
                    ]),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        title: Text("My Info"),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          child: Center(
                                            child: Text(
                                              state.teacherData.response!.fullName![0],
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 4,
                                          children: [
                                            Text(
                                              state.teacherData.response!.fullName ?? '',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor2,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              spacing: 4,
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  size: 17,
                                                ),
                                                Text(
                                                  state.teacherData.response!.email ?? '',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.textColor2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    _infoTile("Phone", "${state.teacherData.response!.contactNumber}",
                                        FontAwesomeIcons.phone),
                                    _infoTile("Subject", state.teacherData.response!.subject, FontAwesomeIcons.book),
                                    _infoTile("Qualification", state.teacherData.response!.qualification,
                                        FontAwesomeIcons.university),
                                    _infoTile("Experience (years)", "${state.teacherData.response!.experienceYears}",
                                        FontAwesomeIcons.schoolCircleCheck),
                                    _infoTile("Class Assigned", state.teacherData.response!.classAssigned,
                                        FontAwesomeIcons.userGroup),
                                    _infoTile(
                                        "Teacher Code", state.teacherData.response!.teacherCode, FontAwesomeIcons.code),
                                    _infoTile(
                                        "Address", state.teacherData.response!.address, FontAwesomeIcons.addressCard),
                                    _infoTile(
                                        "Joined On",
                                        locatorDI<Helper>()
                                            .formatTimeFronUnixTimeStamp(state.teacherData.response?.createdAt ?? 0),
                                        FontAwesomeIcons.clock),
                                  ],
                                ),
                              ),
                            ),
                          )
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
                Padding(
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
              ],
            );
          }
        },
      ),
    );
  }

  Widget _infoTile(String title, String? value, IconData icon) {
    return ListTile(
      minVerticalPadding: 8,
      minTileHeight: 60,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          icon,
          size: 17,
          color: AppColors.primaryColor,
        ),
      ),
      contentPadding: EdgeInsets.all(0),
      title: Text(
        title,
        style: TextStyle(color: AppColors.textColor2, fontSize: 10, fontWeight: FontWeight.w400),
      ),
      subtitle: Text(
        value ?? '-',
        style: TextStyle(color: AppColors.textColor2, fontSize: 13, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
