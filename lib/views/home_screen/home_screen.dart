import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutr_frontend/constants/app_colors.dart';
import 'package:tutr_frontend/core/common/custom_loading_widget.dart';
import 'package:tutr_frontend/models/arguments/teacher_view_group_arguments.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';
import 'package:tutr_frontend/themes/styles/custom_text_styles.dart';
import 'package:tutr_frontend/viewmodels/home_bloc/bloc/home_screen_bloc.dart';
import 'package:tutr_frontend/widgets/home_widgets/group_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            if (state.homeScreenLoading) {
              return CustomLoadingWidget();
            } else if (state.teacherStudentGroupError.isNotEmpty) {
              return Center(
                child: Text(
                  state.teacherStudentGroupError,
                  style: CustomTextStyles.errorTextStyle,
                ),
              );
            } else if (state.teacherStudentGroupData.response?.isNotEmpty ?? false) {
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.teacherStudentGroupData.response?.length ?? 0,
                    itemBuilder: (context, index) {
                      final group = state.teacherStudentGroupData.response?[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouteNames.teacherViewGroup,
                              arguments: TeacherViewGroupArguments(
                                  groupTitle: group?.groupName ?? "",
                                  groupId: group?.groupId ?? "",
                                  teacherName: (group?.allMembers != null && (group?.allMembers?.isNotEmpty ?? false))
                                      ? (group?.allMembers?[0].groupOwnerName ?? "")
                                      : (group?.groupName ?? ""),
                                  teacherId: group?.teacherId ?? "",
                                  className: group?.groupClass ?? ""));

                         
                        },
                        child: GroupTileWidget(
                            circleTitleText: group?.groupName?[0].toUpperCase() ?? "",
                            title: group?.groupName ?? "",
                            groupDesc: group?.groupDesc ?? "",
                            className: group?.groupClass ?? "",
                            timeStamp: group?.createdAt ?? 0,
                            totalMembers: (group?.allMembers?.length ?? 0).toString()),
                      );
                    },
                  )),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
