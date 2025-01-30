// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tutr/features/groups_and_manage/models/teacher/teacher_groups_model.dart';

class GroupManageStates extends Equatable {
  final bool teacherGroupsLoading;
  final String teacherGroupError;
  final TeacherGroupsModel teacherGroupsModelData;
  final List<String> listOfClasses;
  final String selectedClass;
  final bool createGroupLoading;
  final int bottomBarIndex;

  const GroupManageStates({
    required this.teacherGroupsLoading,
    required this.teacherGroupError,
    required this.teacherGroupsModelData,
    required this.listOfClasses,
    required this.selectedClass,
    required this.createGroupLoading,
    required this.bottomBarIndex,
  });

  factory GroupManageStates.init() {
    return GroupManageStates(
        teacherGroupsLoading: false,
        teacherGroupError: "",
        selectedClass: "9TH",
        bottomBarIndex: 0,
        createGroupLoading: false,
        teacherGroupsModelData: TeacherGroupsModel(),
        listOfClasses: ["9TH", "10TH", "11TH", "12TH"]);
  }

  @override
  List<Object> get props {
    return [
      teacherGroupsLoading,
      teacherGroupError,
      teacherGroupsModelData,
      listOfClasses,
      selectedClass,
      createGroupLoading,
      bottomBarIndex,
    ];
  }

  GroupManageStates copyWith({
    bool? teacherGroupsLoading,
    String? teacherGroupError,
    TeacherGroupsModel? teacherGroupsModelData,
    List<String>? listOfClasses,
    String? selectedClass,
    bool? createGroupLoading,
    int? bottomBarIndex,
  }) {
    return GroupManageStates(
      teacherGroupsLoading: teacherGroupsLoading ?? this.teacherGroupsLoading,
      teacherGroupError: teacherGroupError ?? this.teacherGroupError,
      teacherGroupsModelData: teacherGroupsModelData ?? this.teacherGroupsModelData,
      listOfClasses: listOfClasses ?? this.listOfClasses,
      selectedClass: selectedClass ?? this.selectedClass,
      createGroupLoading: createGroupLoading ?? this.createGroupLoading,
      bottomBarIndex: bottomBarIndex ?? this.bottomBarIndex,
    );
  }
}
