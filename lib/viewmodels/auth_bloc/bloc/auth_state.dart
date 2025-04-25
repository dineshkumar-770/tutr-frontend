// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final int activeStep;
  final bool sendOTPLoading;
  final String sendOTPError;
  final List<String> listOfClasses;
  final String selectedClass;
  final bool registerStudentLoading;
  final bool registerTeacherLoading;
  final double selectedExperience;
  final List<String> listOfSelectedClasses;
  final List<String> listOfSubjects;
  final String selectedSubject;
  final bool verifyOTPLoading;
  final bool navigateToHome;
  const AuthState({
    required this.activeStep,
    required this.sendOTPLoading,
    required this.sendOTPError,
    required this.listOfClasses,
    required this.selectedClass,
    required this.registerStudentLoading,
    required this.registerTeacherLoading,
    required this.selectedExperience,
    required this.listOfSelectedClasses,
    required this.listOfSubjects,
    required this.selectedSubject,
    required this.verifyOTPLoading,
    required this.navigateToHome,
  });

  factory AuthState.init() {
    return AuthState(
        activeStep: 0,
        verifyOTPLoading: false,
        sendOTPLoading: false,
        registerStudentLoading: false,
        registerTeacherLoading: false,
        navigateToHome: false,
        sendOTPError: "",
        selectedSubject: "Physics",
        listOfSubjects: [
          'Physics',
          'Chemistry',
          'Mathematics',
          'Biology',
          'English',
          'Computer Science',
          'Physical Education',
          'Environmental Science',
          'Accountancy',
          'Business Studies',
          'Economics',
          'Informatics Practices',
          'Entrepreneurship',
          'History',
          'Political Science',
          'Geography',
          'Psychology',
          'Sociology',
          'Hindi',
          'Fine Arts',
        ],
        listOfSelectedClasses: [],
        selectedExperience: 8,
        listOfClasses: ["9TH", "10TH", "11TH", "12TH"],
        selectedClass: "9TH");
  }

  @override
  List<Object> get props => [
        activeStep,
        sendOTPLoading,
        navigateToHome,
        sendOTPError,
        verifyOTPLoading,
        listOfClasses,
        selectedClass,
        selectedSubject,
        registerStudentLoading,
        selectedExperience,
        registerTeacherLoading,
        listOfSelectedClasses,
        listOfSubjects
      ];

  AuthState copyWith({
    int? activeStep,
    bool? sendOTPLoading,
    String? sendOTPError,
    List<String>? listOfClasses,
    String? selectedClass,
    bool? registerStudentLoading,
    bool? registerTeacherLoading,
    double? selectedExperience,
    List<String>? listOfSelectedClasses,
    List<String>? listOfSubjects,
    String? selectedSubject,
    bool? verifyOTPLoading,
    bool? navigateToHome,
  }) {
    return AuthState(
      activeStep: activeStep ?? this.activeStep,
      sendOTPLoading: sendOTPLoading ?? this.sendOTPLoading,
      sendOTPError: sendOTPError ?? this.sendOTPError,
      listOfClasses: listOfClasses ?? this.listOfClasses,
      selectedClass: selectedClass ?? this.selectedClass,
      registerStudentLoading: registerStudentLoading ?? this.registerStudentLoading,
      registerTeacherLoading: registerTeacherLoading ?? this.registerTeacherLoading,
      selectedExperience: selectedExperience ?? this.selectedExperience,
      listOfSelectedClasses: listOfSelectedClasses ?? this.listOfSelectedClasses,
      listOfSubjects: listOfSubjects ?? this.listOfSubjects,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      verifyOTPLoading: verifyOTPLoading ?? this.verifyOTPLoading,
      navigateToHome: navigateToHome ?? this.navigateToHome,
    );
  }
}
