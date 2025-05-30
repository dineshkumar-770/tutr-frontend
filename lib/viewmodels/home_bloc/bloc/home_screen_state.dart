// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_screen_bloc.dart';

class HomeScreenState extends Equatable {
  final bool homeScreenLoading;
  final TeacherStudentGroupModel teacherStudentGroupData;
  final StudentTeacherGroupModel studentTeacherGroupData;
  final String teacherStudentGroupError;
  final bool userProfileLoading;
  final TeacherDataModel teacherData;
  final StudentProfileModel studentProfileData;
  final String userProfileError;
  final String selectedClass;
  final bool createGroupLoading;
  final String createGroupError;
  final PackageInfo packageInfo;
  const HomeScreenState({
    required this.homeScreenLoading,
    required this.teacherStudentGroupData,
    required this.studentTeacherGroupData,
    required this.teacherStudentGroupError,
    required this.userProfileLoading,
    required this.teacherData,
    required this.studentProfileData,
    required this.userProfileError,
    required this.selectedClass,
    required this.createGroupLoading,
    required this.createGroupError,
    required this.packageInfo,
  });

  factory HomeScreenState.init() {
    return HomeScreenState(
        homeScreenLoading: false,
        teacherStudentGroupData: TeacherStudentGroupModel(),
        teacherStudentGroupError: "",
        studentTeacherGroupData: StudentTeacherGroupModel(),
        teacherData: TeacherDataModel(),
        studentProfileData: StudentProfileModel(),
        userProfileLoading: false,
        packageInfo: PackageInfo(appName: "", packageName: "", version: "", buildNumber: ""),
        selectedClass: "",
        createGroupError: "",
        createGroupLoading: false,
        userProfileError: "");
  }

  @override
  List<Object> get props => [
        homeScreenLoading,
        teacherStudentGroupData,
        teacherStudentGroupError,
        userProfileError,
        userProfileLoading,
        createGroupError,
        createGroupLoading,
        packageInfo,
        teacherData,
        selectedClass,
        studentTeacherGroupData,
        studentProfileData,
      ];

  HomeScreenState copyWith({
    bool? homeScreenLoading,
    TeacherStudentGroupModel? teacherStudentGroupData,
    StudentTeacherGroupModel? studentTeacherGroupData,
    String? teacherStudentGroupError,
    bool? userProfileLoading,
    TeacherDataModel? teacherData,
    StudentProfileModel? studentProfileData,
    String? userProfileError,
    String? selectedClass,
    bool? createGroupLoading,
    String? createGroupError,
    PackageInfo? packageInfo,
  }) {
    return HomeScreenState(
      homeScreenLoading: homeScreenLoading ?? this.homeScreenLoading,
      teacherStudentGroupData: teacherStudentGroupData ?? this.teacherStudentGroupData,
      studentTeacherGroupData: studentTeacherGroupData ?? this.studentTeacherGroupData,
      teacherStudentGroupError: teacherStudentGroupError ?? this.teacherStudentGroupError,
      userProfileLoading: userProfileLoading ?? this.userProfileLoading,
      teacherData: teacherData ?? this.teacherData,
      studentProfileData: studentProfileData ?? this.studentProfileData,
      userProfileError: userProfileError ?? this.userProfileError,
      selectedClass: selectedClass ?? this.selectedClass,
      createGroupLoading: createGroupLoading ?? this.createGroupLoading,
      createGroupError: createGroupError ?? this.createGroupError,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }
}
