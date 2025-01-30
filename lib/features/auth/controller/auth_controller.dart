import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutr/common/custom_message_widget.dart';
import 'package:tutr/features/auth/controller/auth_states.dart';
import 'package:tutr/features/auth/models/all_teachers_model.dart';
import 'package:tutr/features/groups_and_manage/views/home_screen.dart';
import 'package:tutr/resources/constant_strings.dart';
import 'package:tutr/service/api_calls.dart';
import 'package:tutr/service/api_result.dart';
import 'package:tutr/utils/shared_prefs.dart';

final authNotifierProvider = StateNotifierProvider.autoDispose<AuthNotifier, AuthStates>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthStates> {
  AuthNotifier() : super(AuthStates.initiate());

  final ApiCalls _apiService = ApiCalls();

  TextEditingController emailController = TextEditingController();
  TextEditingController emailOTPController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController studentContactController = TextEditingController();
  TextEditingController classRoomController = TextEditingController();
  TextEditingController parentsContactController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();

  void changeActiveStep(int value) {
    state = state.copyWith(loginActiveStep: value);
  }

  Future<void> sendEmailOTP({required String loginType, required String email, required BuildContext context}) async {
    state = state.copyWith(sendOTPLoading: true);
    final response = await _apiService.sendEmailOTP(loginType: loginType, email: email);
    if (response is SuccessState) {
      final decodedData = jsonDecode(response.value);
      log(decodedData.toString());
      if (decodedData["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
        changeActiveStep(1);
        if (context.mounted) {
          CustomSnackbar.show(context: context, message: decodedData["message"].toString(), isSuccess: true);
        }
      } else {
        if (context.mounted) {
          CustomSnackbar.show(context: context, message: decodedData["message"].toString(), isSuccess: false);
        }
      }
    } else if (response is ErrorState) {
      final msg = response.msg;
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: msg, isSuccess: true);
      }
    } else {
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: "Something went wrong", isSuccess: false);
      }
    }

    state = state.copyWith(sendOTPLoading: false);
  }

  Future<void> verifyEmailOTP(
      {required String loginType, required String email, required String otp, required BuildContext context}) async {
    state = state.copyWith(verifyOTPLoading: false);
    final response = await _apiService.verifyEmailOTP(loginType: loginType, email: email, otp: otp);
    if (response is SuccessState) {
      final decodedData = jsonDecode(response.value);
      log(decodedData.toString());
      if (decodedData["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
        await Prefs.setString(ConstantStrings.tokenKey, decodedData["response"].toString());
        if (context.mounted) {
          CustomSnackbar.show(context: context, message: decodedData["message"].toString(), isSuccess: true);
        }
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }
      } else {
        if (context.mounted) {
          CustomSnackbar.show(context: context, message: decodedData["message"].toString(), isSuccess: false);
        }
      }
    } else if (response is ErrorState) {
      final msg = response.msg;
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: msg, isSuccess: true);
      }
    } else {
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: "Something went wrong", isSuccess: false);
      }
    }
  }

  Future<void> getAllTeachersList() async {
    state = state.copyWith(getTeachersLoading: true);
    final response = await _apiService.getTeachersList();
    AllTeachersModel allTeachersModel = state.allTeachersModelData;
    if (response is SuccessState) {
      log(response.value.toString());
      final decodedData = jsonDecode(response.value);
      if (decodedData["status"].toString() == ConstantStrings.success) {
        allTeachersModel = AllTeachersModel.fromJson(decodedData);
      } else {
        allTeachersModel =
            AllTeachersModel(response: [], message: decodedData["message"].toString(), status: ConstantStrings.failed);
      }
      state = state.copyWith(
          allTeachersModelData: allTeachersModel, getTeachersLoading: false, selectedTeacher: allTeachersModel.response[0]);
      log(decodedData.toString());
    } else if (response is ErrorState) {
      final message = response.msg;
      log(message.toString());
      allTeachersModel = AllTeachersModel(response: [], message: message.toString(), status: ConstantStrings.failed);
      state = state.copyWith(allTeachersModelData: allTeachersModel, getTeachersLoading: false);
    } else {
      log("Something went wrong");
      allTeachersModel = AllTeachersModel(response: [], message: "Something went wrong", status: ConstantStrings.failed);
      state = state.copyWith(allTeachersModelData: allTeachersModel, getTeachersLoading: false);
    }
  }

  Future<void> registerStudent(
      {required String fullName,
      required String email,
      required String studentPhoneNumber,
      required String classroom,
      required String teacherCode,
      required String parentsPhoneNumber,
      required String fullAddress,
      required BuildContext context}) async {
    state = state.copyWith(registerLoading: true);
    final response = await _apiService.registerStudents(
        fullName: fullName,
        email: email,
        studentPhoneNumber: studentPhoneNumber,
        classroom: classroom,
        teacherCode: teacherCode,
        parentsPhoneNumber: parentsPhoneNumber,
        fullAddress: fullAddress);

    if (response is SuccessState) {
      final decodedData = jsonDecode(response.value);
      log(decodedData.toString());
      if (decodedData["status"].toString() == ConstantStrings.success) {
        fullNameController.clear();
        studentEmailController.clear();
        studentContactController.clear();
        classRoomController.clear();
        parentsContactController.clear();
        fullAddressController.clear();
        if (context.mounted) {
          if (context.mounted) {
            Navigator.pop(context);
          }
          CustomSnackbar.show(context: context, message: decodedData["message"].toString(), isSuccess: true);
        } else {
          if (context.mounted) {
            CustomSnackbar.show(context: context, message: decodedData["message"].toString(), isSuccess: false);
          }
        }
      }
    } else if (response is ErrorState) {
      final message = response.msg;
      log(message.toString());
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: message.toString(), isSuccess: false);
      }
    } else {
      log("Something went wrong");
      if (context.mounted) {
        CustomSnackbar.show(context: context, message: "Something went wrong", isSuccess: false);
      }
    }
    state = state.copyWith(registerLoading: false);
  }

  void selectClassroom(String value) {
    state = state.copyWith(selectedClass: value);
  }

  void selectTeacher(TeachersData teacher) {
    state = state.copyWith(selectedTeacher: teacher);
  }
}
