import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/repository/api_calls.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';
import 'package:tutr_frontend/routes/app_route_names.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.context}) : super(AuthState.init()) {
    on<ActiveStepEvent>(changeActiveStep);
    on<SendOTPEvent>(sendOTPEmail);
    on<RegisterUserCollectInfoEvent>(selectClass);
    on<RegisterUserEvent>(registerUserTeacherORStudent);
    on<ChooseExperienceEvent>(chooseYearsOfExperience);
    on<ChooseTeacherSubject>(selectSubjectTeacher);
    on<VerifyOTPEvent>(verifyOTP);
  }

  final ApiCalls _apiCalls = locatorDI<ApiCalls>();
  BuildContext context;

  void changeActiveStep(ActiveStepEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(activeStep: event.activeStep));
  }

  Future<void> sendOTPEmail(SendOTPEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(sendOTPLoading: true));
    final response = await _apiCalls.sentOTPToEmail(email: event.email, loginType: event.userType);
    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          emit(state.copyWith(activeStep: event.activeStep, sendOTPError: "", sendOTPLoading: false));
        } else {
          emit(state.copyWith(sendOTPError: data["message"].toString(), sendOTPLoading: false));
        }
      },
      (error) {
        emit(state.copyWith(sendOTPError: error, sendOTPLoading: false));
        CustomToast.show(toastType: ToastificationType.error, context: context, title: error);
      },
    );
  }

  void selectClass(RegisterUserCollectInfoEvent event, Emitter<AuthState> emit) {
    if (event.userType == ConstantStrings.student) {
      emit(state.copyWith(selectedClass: event.selectedClass));
    } else if (event.userType == ConstantStrings.teacher) {
      List<String> updatedClasses = List.from(event.selectedClasses);
      if (updatedClasses.contains(event.selectedClass)) {
        updatedClasses.remove(event.selectedClass); // unselect
      } else {
        updatedClasses.add(event.selectedClass); // select
      }
      emit(state.copyWith(listOfSelectedClasses: updatedClasses));
      log(state.listOfSelectedClasses.join(","));
    }
  }

  Future<void> registerUserTeacherORStudent(RegisterUserEvent event, Emitter<AuthState> emit) async {
    if (event.userType == ConstantStrings.student) {
      emit(state.copyWith(registerStudentLoading: true));
      final response = await _apiCalls.resgiterStudent(
          email: event.email,
          name: event.name,
          personalContect: event.personalContect,
          address: event.address,
          classAssigned: event.classAssigned,
          parentsContact: event.parentsContact);

      response.fold(
        (data) {
          if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
            emit(state.copyWith(registerStudentLoading: false));
            CustomToast.show(
                toastType: ToastificationType.success, context: context, title: data["message"].toString());
          } else {
            emit(state.copyWith(registerStudentLoading: false));
            CustomToast.show(toastType: ToastificationType.error, context: context, title: data["message"].toString());
          }
        },
        (error) {
          emit(state.copyWith(registerStudentLoading: false));
          CustomToast.show(toastType: ToastificationType.error, context: context, title: error);
        },
      );
    } else if (event.userType == ConstantStrings.teacher) {
      emit(state.copyWith(registerTeacherLoading: true));
      final response = await _apiCalls.registerTeacher(
          email: event.email,
          name: event.name,
          personalContect: event.personalContect,
          address: event.address,
          classAssigned: event.classAssigned,
          exprience: event.exprience,
          qualifications: event.qualifications,
          subject: event.subject,
          teacherCode: event.teacherCode);

      response.fold(
        (data) {
          if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
            emit(state.copyWith(registerTeacherLoading: false));
            CustomToast.show(
                toastType: ToastificationType.success, context: context, title: data["message"].toString());
          } else {
            emit(state.copyWith(registerTeacherLoading: false));
            CustomToast.show(toastType: ToastificationType.error, context: context, title: data["message"].toString());
          }
        },
        (error) {
          emit(state.copyWith(registerTeacherLoading: false));
          CustomToast.show(toastType: ToastificationType.error, context: context, title: error);
        },
      );
    }
  }

  void chooseYearsOfExperience(ChooseExperienceEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(selectedExperience: event.experienceYears));
  }

  void selectSubjectTeacher(ChooseTeacherSubject event, Emitter<AuthState> emit) {
    emit(state.copyWith(selectedSubject: event.selectedSubject));
  }

  Future<void> verifyOTP(VerifyOTPEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(verifyOTPLoading: true));
    final response = await _apiCalls.verifyEmailOTP(otp: event.otp, email: event.email, loginType: event.loginType);

    response.fold(
      (data) async {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          emit(state.copyWith(verifyOTPLoading: false));
          CustomToast.show(toastType: ToastificationType.success, context: context, title: data["message"].toString());
          await Prefs.setString(ConstantStrings.userToken, data["response"].toString());
          await Prefs.setString(ConstantStrings.userType, event.loginType);
          await Future.delayed(const Duration(seconds: 3));
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouteNames.rootScreen,
              (Route<dynamic> route) => false,
            );
          }
        } else {
          emit(state.copyWith(verifyOTPLoading: false));
          CustomToast.show(toastType: ToastificationType.error, context: context, title: data["message"].toString());
        }
      },
      (err) {
        emit(state.copyWith(verifyOTPLoading: false));
        CustomToast.show(toastType: ToastificationType.error, context: context, title: err);
      },
    );
  }
}
