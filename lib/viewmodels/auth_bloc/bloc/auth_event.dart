// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ActiveStepEvent extends AuthEvent {
  final int activeStep;

  const ActiveStepEvent({required this.activeStep});
  @override
  List<Object> get props => [activeStep];
}

class SendOTPEvent extends AuthEvent {
  final String email;
  final String userType;
  final int activeStep;

  const SendOTPEvent({required this.email, required this.userType, required this.activeStep});
  @override
  List<Object> get props => [userType, email, activeStep];
}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String name;
  final String personalContect;
  final String subject;
  final String qualifications;
  final int exprience;
  final String address;
  final String classAssigned;
  final String teacherCode;
  final String parentsContact;
  final String userType;

  const RegisterUserEvent(
      {required this.email,
      required this.name,
      required this.personalContect,
      required this.subject,
      required this.qualifications,
      required this.exprience,
      required this.address,
      required this.classAssigned,
      required this.teacherCode,
      required this.userType,
      required this.parentsContact});
  @override
  List<Object> get props => [
        email,
        name,
        personalContect,
        subject,
        qualifications,
        exprience,
        address,
        classAssigned,
        teacherCode,
        parentsContact,
        userType,
      ];
}

class RegisterUserCollectInfoEvent extends AuthEvent {
  final String selectedClass;
  final List<String> selectedClasses;
  final String userType;

  const RegisterUserCollectInfoEvent({
    required this.selectedClass,
    required this.selectedClasses,
    required this.userType,
  });

  @override
  List<Object> get props => [selectedClass, selectedClasses, userType];
}

class ChooseExperienceEvent extends AuthEvent {
  final double experienceYears;

  const ChooseExperienceEvent({required this.experienceYears});
  @override
  List<Object> get props => [experienceYears];
}

class ChooseTeacherSubject extends AuthEvent {
  final String selectedSubject;

  const ChooseTeacherSubject({required this.selectedSubject});

  @override
  List<Object> get props => [selectedSubject];
}

class VerifyOTPEvent extends AuthEvent {
  final String otp;
  final String email;
  final String loginType;

  const VerifyOTPEvent({required this.otp, required this.email, required this.loginType});
  @override
  List<Object> get props => [loginType, otp, email];
}
