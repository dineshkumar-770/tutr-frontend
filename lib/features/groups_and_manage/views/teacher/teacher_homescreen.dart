import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutr/common/custom_appbar.dart';
import 'package:tutr/common/custom_loading_widget.dart';
import 'package:tutr/features/groups_and_manage/controller/group_manage_controller.dart';
import 'package:tutr/features/groups_and_manage/views/teacher/group_screen.dart';
import 'package:tutr/resources/app_colors.dart';

class TeacherHomescreen extends ConsumerWidget {
  const TeacherHomescreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final teacherState = ref.watch(groupManageNotifierProvider);
    final providerFunc = ref.read(groupManageNotifierProvider.notifier);
    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          title: "Welcome",
          leadingWidget: SizedBox(),
          centerTitle: true,
        ),
        body: teacherState.teacherGroupsLoading
            ? Center(
                child: CustomLoadingWidget(),
              )
            : teacherState.teacherGroupError.isNotEmpty
                ? Center(
                    child: Text(teacherState.teacherGroupError),
                  )
                : Column(
                    children: [
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () async {
                          providerFunc.fetchTeacherGroups();
                        },
                        child: ListView.builder(
                          itemCount: teacherState.teacherGroupsModelData.response?.length ?? 0,
                          itemBuilder: (context, index) {
                            final groups = teacherState.teacherGroupsModelData.response?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(spreadRadius: 0, blurRadius: 2, color: Colors.black45, blurStyle: BlurStyle.outer)
                                ], color: AppColors.white, borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      isThreeLine: false,
                                      contentPadding: EdgeInsets.all(0),
                                      minVerticalPadding: 0,
                                      onTap: () {
                                        providerFunc.fetchGroupNotices(groupId: groups?.groupId ?? "", context: context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => GroupScreenTeacher(
                                                groupTitle: groups?.groupName ?? "",
                                              ),
                                            ));
                                      },
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.textColor1,
                                        size: 15,
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: AppColors.primaryColor,
                                        child: Center(
                                          child: Text(
                                            groups?.groupName?[0].toUpperCase() ?? "",
                                            style: GoogleFonts.lato(fontSize: 16, color: AppColors.textColor1),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        groups?.groupName ?? "",
                                        style: GoogleFonts.lato(fontSize: 16, color: AppColors.textColor1),
                                      ),
                                      subtitle: Text(
                                        "${groups?.allMembers?.length ?? 0} Students",
                                        style: GoogleFonts.lato(
                                            fontSize: 12, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "•  ${groups?.groupDesc ?? "No group description yet!"}",
                                      style: GoogleFonts.lato(
                                          fontSize: 14, color: AppColors.textColor1, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ))
                    ],
                  ));
  }
}
