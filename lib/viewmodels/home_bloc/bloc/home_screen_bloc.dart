import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/repository/api_calls.dart';
import 'package:tutr_frontend/models/home_screen_models/teacher_student_group.dart';
import 'package:tutr_frontend/models/profile_models/teacher_profile_model.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState.init()) {
    on<FetchHomeScreenDataEvent>(fetchTeacherStudentGroups);
    on<FetchUserProfileEvent>(fetchUserProfile);
    on<SelectClassForGroupcreationEvent>(selectClassForGroupcreation);
    on<CreateGroupEvent>(createTeacherGroup);
  }

  final ApiCalls _apiCalls = locatorDI<ApiCalls>();

  Future<void> fetchTeacherStudentGroups(FetchHomeScreenDataEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(homeScreenLoading: true));
    final response = await _apiCalls.getStudentTeachersGroups();

    response.fold(
      (data) {
        TeacherStudentGroupModel teacherStudentGroupModel = TeacherStudentGroupModel();
        try {
          teacherStudentGroupModel = TeacherStudentGroupModel.fromJson(data);
          if (teacherStudentGroupModel.status?.toLowerCase() == ConstantStrings.success.toLowerCase()) {
            emit(state.copyWith(
                homeScreenLoading: false,
                teacherStudentGroupError: "",
                teacherStudentGroupData: teacherStudentGroupModel));
          } else {
            emit(state.copyWith(
                homeScreenLoading: false,
                teacherStudentGroupError: teacherStudentGroupModel.message,
                teacherStudentGroupData: teacherStudentGroupModel));
          }
        } catch (e) {
          emit(state.copyWith(
              homeScreenLoading: false,
              teacherStudentGroupError: e.toString(),
              teacherStudentGroupData: teacherStudentGroupModel));
        }
      },
      (error) {
        emit(state.copyWith(teacherStudentGroupError: error));
      },
    );
  }

  Future<void> fetchUserProfile(FetchUserProfileEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(userProfileLoading: true));
    final response = await _apiCalls.fetchUserProfileData();
    final packageInfo = await _fetchAppVersion();

    response.fold(
      (data) {
        TeacherDataModel teacherDataModel = TeacherDataModel();
        try {
          if (data["status"].toString().toLowerCase() == ConstantStrings.success) {
            teacherDataModel = TeacherDataModel.fromJson(data);
            emit(state.copyWith(
                userProfileError: "",
                userProfileLoading: false,
                teacherData: teacherDataModel,
                packageInfo: packageInfo));
          } else {
            emit(state.copyWith(
                userProfileError: data["message"].toString(),
                userProfileLoading: false,
                teacherData: teacherDataModel,
                packageInfo: packageInfo));
            CustomToast.show(
                toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
          }
        } catch (e) {
          emit(state.copyWith(userProfileError: e.toString(), userProfileLoading: false, packageInfo: packageInfo));
          CustomToast.show(
              toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
        }
      },
      (error) {
        emit(state.copyWith(userProfileLoading: false, userProfileError: error, packageInfo: packageInfo));
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: error);
      },
    );
  }

  void selectClassForGroupcreation(SelectClassForGroupcreationEvent event, Emitter<HomeScreenState> emit) {
    final value = event.value;
    log("Event Received: $value");
    emit(state.copyWith(selectedClass: value));
    log("Updated State: ${state.selectedClass}");
  }

  Future<void> createTeacherGroup(CreateGroupEvent event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(createGroupLoading: true));
    final response = await _apiCalls.createGroupTeacher(
        groupClass: event.groupClass, groupName: event.groupTitle, groupDescription: event.groupDescription);

    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          emit(state.copyWith(
            createGroupError: "",
            createGroupLoading: false,
          ));
          CustomToast.show(
              toastType: ToastificationType.success, context: event.context, title: data["message"].toString());
        } else {
          emit(state.copyWith(
            createGroupError: data["message"],
            createGroupLoading: false,
          ));
          CustomToast.show(
              toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
        }
      },
      (error) {
        emit(state.copyWith(
          createGroupError: error,
          createGroupLoading: false,
        ));
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: error);
      },
    );
  }

  Future<PackageInfo> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
