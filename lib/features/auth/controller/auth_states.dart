// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tutr/features/auth/models/all_teachers_model.dart';
import 'package:tutr/resources/constant_strings.dart';

class AuthStates extends Equatable {
  final bool sendOTPLoading;
  final int loginActiveStep;
  final bool registerLoading;
  final List<String> listOfClasses;
  final String selectedClass;
  final bool getTeachersLoading;
  final TeachersData selectedTeacher;
  final AllTeachersModel allTeachersModelData;
  final bool verifyOTPLoading;

  const AuthStates({
    required this.sendOTPLoading,
    required this.loginActiveStep,
    required this.registerLoading,
    required this.listOfClasses,
    required this.selectedClass,
    required this.getTeachersLoading,
    required this.selectedTeacher,
    required this.allTeachersModelData,
    required this.verifyOTPLoading,
  });

  factory AuthStates.initiate() {
    return AuthStates(
        sendOTPLoading: false,
        loginActiveStep: 0,
        registerLoading: false,
        selectedTeacher: TeachersData(),
        verifyOTPLoading: false,
        getTeachersLoading: false,
        allTeachersModelData: AllTeachersModel(response: [], message: "", status: ConstantStrings.failed),
        selectedClass: "9TH",
        listOfClasses: ["9TH", "10TH", "11TH", "12TH"]);
  }

  @override
  List<Object> get props {
    return [
      sendOTPLoading,
      loginActiveStep,
      registerLoading,
      listOfClasses,
      selectedClass,
      getTeachersLoading,
      selectedTeacher,
      allTeachersModelData,
      verifyOTPLoading,
    ];
  }

  AuthStates copyWith({
    bool? sendOTPLoading,
    int? loginActiveStep,
    bool? registerLoading,
    List<String>? listOfClasses,
    String? selectedClass,
    bool? getTeachersLoading,
    TeachersData? selectedTeacher,
    AllTeachersModel? allTeachersModelData,
    bool? verifyOTPLoading,
  }) {
    return AuthStates(
      sendOTPLoading: sendOTPLoading ?? this.sendOTPLoading,
      loginActiveStep: loginActiveStep ?? this.loginActiveStep,
      registerLoading: registerLoading ?? this.registerLoading,
      listOfClasses: listOfClasses ?? this.listOfClasses,
      selectedClass: selectedClass ?? this.selectedClass,
      getTeachersLoading: getTeachersLoading ?? this.getTeachersLoading,
      selectedTeacher: selectedTeacher ?? this.selectedTeacher,
      allTeachersModelData: allTeachersModelData ?? this.allTeachersModelData,
      verifyOTPLoading: verifyOTPLoading ?? this.verifyOTPLoading,
    );
  }
}
