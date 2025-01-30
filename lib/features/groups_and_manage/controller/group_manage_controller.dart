import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutr/common/custom_message_widget.dart';
import 'package:tutr/features/groups_and_manage/controller/group_manage_states.dart';
import 'package:tutr/features/groups_and_manage/models/teacher/teacher_groups_model.dart';
import 'package:tutr/resources/constant_strings.dart';
import 'package:tutr/service/api_calls.dart';
import 'package:tutr/service/api_result.dart';

final groupManageNotifierProvider = StateNotifierProvider<GroupManageNotifier, GroupManageStates>((ref) {
  return GroupManageNotifier();
});

class GroupManageNotifier extends StateNotifier<GroupManageStates> {
  GroupManageNotifier() : super(GroupManageStates.init()) {
    fetchTeacherGroups();
  }
  final ApiCalls _apiService = ApiCalls();
  TextEditingController groupCreateClass = TextEditingController();
  TextEditingController groupTitle = TextEditingController();
  TextEditingController groupDescription = TextEditingController();

  Future<void> fetchTeacherGroups() async {
    state = state.copyWith(teacherGroupsLoading: true);
    final response = await _apiService.getTeacherGroups();
    if (response is SuccessState) {
      final decodedData = jsonDecode(response.value);
      log(decodedData.toString());
      if (decodedData["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
        final teacherGroupsModel = TeacherGroupsModel.fromJson(decodedData);
        state = state.copyWith(teacherGroupError: "", teacherGroupsLoading: false, teacherGroupsModelData: teacherGroupsModel);
      } else {
        state = state.copyWith(teacherGroupError: decodedData["message"].toString(), teacherGroupsLoading: false);
      }
    } else if (response is ErrorState) {
      final msg = response.msg;

      state = state.copyWith(teacherGroupError: msg, teacherGroupsLoading: false);
    } else {
      state = state.copyWith(teacherGroupError: "Something went wrong", teacherGroupsLoading: false);
    }
  }

  void selectClassroom(String value) {
    state = state.copyWith(selectedClass: value);
  }

  Future<void> createTeachersGroups(
      {required String className,
      required String groupTitle,
      required String groupDescription,
      required BuildContext context}) async {
    state = state.copyWith(createGroupLoading: true);
    final response =
        await _apiService.createGroup(className: className, groupTitle: groupTitle, groupDescription: groupDescription);

    if (response is SuccessState) {
      final decodedData = jsonDecode(response.value);
      log(decodedData.toString());
      state = state.copyWith(createGroupLoading: false);
      if (decodedData["status"].toString() == ConstantStrings.success.toLowerCase()) {
        switchBottomBarTab(0);
        if (context.mounted) {
          CustomSnackbar.show(context: context, message: decodedData["message"], isSuccess: true);
        }
      } else {
        if (context.mounted) {
          CustomSnackbar.show(context: context, message: decodedData["message"], isSuccess: false);
        }
      }
    } else if (response is ErrorState) {
      final msg = response.msg;
      state = state.copyWith(createGroupLoading: true);
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: msg, isSuccess: false);
      }
    } else {
      state = state.copyWith(createGroupLoading: true);
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: "Something went wrong", isSuccess: false);
      }
    }
  }

  void switchBottomBarTab(int index) {
    state = state.copyWith(bottomBarIndex: index);
  }

  Future<void> fetchGroupNotices({required String groupId, required BuildContext context}) async {
    final response = await _apiService.getGroupNotices(groupId: groupId);
    if (response is SuccessState) {
      final decodedData = jsonDecode(response.value);
      log(decodedData.toString());
    } else if (response is ErrorState) {
      final msg = response.msg;
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: msg, isSuccess: false);
      }
    } else {
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: "Something went wrong", isSuccess: false);
      }
    }
  }
}
