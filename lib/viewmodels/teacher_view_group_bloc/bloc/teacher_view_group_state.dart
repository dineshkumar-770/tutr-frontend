// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'teacher_view_group_bloc.dart';

class TeacherViewGroupState extends Equatable {
  final bool createNoticeLoading;
  final String createNoticeError;
  final bool fetchNoticeLoading;
  final String fetchNoticError;
  final GroupNoticeModel groupNoticeData;
  final bool updateNoticeLoading;
  final String updateNoticeError;
  final bool fetchmembersLoading;
  final String fetchMembersError;
  final List<GroupMember> groupMembersList;
  final List<String> attachedFilePathsList;
  final bool uploadNotesLoading;
  final bool getGroupNotesLoading;
  final String groupNotesError;
  final List<StudyMaterial> groupNotesMaterialdata;
  final bool fetchUserConatcsLoading;
  final List<UserContactsData> userContactsData;
  final Map<String, int> letterIndexMapForContacts;
  final bool checkStudentInviteLoading;
  final String inviteErrorMsg;
  final CheckStudentBeforeInviteModel checkStudentBeforeInviteData;
  final int inviteTappedIndex;
  final bool deleteNotesLoading;
  final String deleteNotesError;
  final int deleteNotesIndex;
  

  const TeacherViewGroupState({
    required this.createNoticeLoading,
    required this.createNoticeError,
    required this.fetchNoticeLoading,
    required this.fetchNoticError,
    required this.groupNoticeData,
    required this.updateNoticeLoading,
    required this.updateNoticeError,
    required this.fetchmembersLoading,
    required this.fetchMembersError,
    required this.groupMembersList,
    required this.attachedFilePathsList,
    required this.uploadNotesLoading,
    required this.getGroupNotesLoading,
    required this.groupNotesError,
    required this.groupNotesMaterialdata,
    required this.fetchUserConatcsLoading,
    required this.userContactsData,
    required this.letterIndexMapForContacts,
    required this.checkStudentInviteLoading,
    required this.inviteErrorMsg,
    required this.checkStudentBeforeInviteData,
    required this.inviteTappedIndex,
    required this.deleteNotesLoading,
    required this.deleteNotesError,
    required this.deleteNotesIndex,
  });

  factory TeacherViewGroupState.init() => TeacherViewGroupState(
      createNoticeLoading: false,
      createNoticeError: "",
      fetchNoticError: "",
      updateNoticeError: "",
      uploadNotesLoading: false,
      deleteNotesError: "",
      deleteNotesLoading: false,
      inviteTappedIndex: 0,
      fetchMembersError: "",
      letterIndexMapForContacts: {},
      checkStudentBeforeInviteData: CheckStudentBeforeInviteModel(),
      checkStudentInviteLoading: false,
      inviteErrorMsg: "",
      fetchUserConatcsLoading: false,
      userContactsData: [],
      fetchmembersLoading: false,
      attachedFilePathsList: [],
      getGroupNotesLoading: false,
      groupNotesError: "",
      groupNotesMaterialdata: [],
      groupMembersList: [],
      deleteNotesIndex: -1,
      updateNoticeLoading: false,
      fetchNoticeLoading: false,
      groupNoticeData: GroupNoticeModel());

  @override
  List<Object> get props => [
        createNoticeLoading,
        fetchUserConatcsLoading,
        createNoticeError,
        fetchNoticError,
        fetchNoticeLoading,
        groupNoticeData,
        deleteNotesError,
        letterIndexMapForContacts,
        attachedFilePathsList,
        userContactsData,
        deleteNotesIndex,
        updateNoticeLoading,
        updateNoticeError,
        groupMembersList,
        deleteNotesLoading,
        uploadNotesLoading,
        fetchMembersError,
        fetchmembersLoading,
        getGroupNotesLoading,
        groupNotesError,
        groupNotesMaterialdata,
        checkStudentInviteLoading,
        inviteErrorMsg,
        checkStudentBeforeInviteData,
        inviteTappedIndex
      ];

  TeacherViewGroupState copyWith({
    bool? createNoticeLoading,
    String? createNoticeError,
    bool? fetchNoticeLoading,
    String? fetchNoticError,
    GroupNoticeModel? groupNoticeData,
    bool? updateNoticeLoading,
    String? updateNoticeError,
    bool? fetchmembersLoading,
    String? fetchMembersError,
    List<GroupMember>? groupMembersList,
    List<String>? attachedFilePathsList,
    bool? uploadNotesLoading,
    bool? getGroupNotesLoading,
    String? groupNotesError,
    List<StudyMaterial>? groupNotesMaterialdata,
    bool? fetchUserConatcsLoading,
    List<UserContactsData>? userContactsData,
    Map<String, int>? letterIndexMapForContacts,
    bool? checkStudentInviteLoading,
    String? inviteErrorMsg,
    CheckStudentBeforeInviteModel? checkStudentBeforeInviteData,
    int? inviteTappedIndex,
    bool? deleteNotesLoading,
    String? deleteNotesError,
    int? deleteNotesIndex,
  }) {
    return TeacherViewGroupState(
      createNoticeLoading: createNoticeLoading ?? this.createNoticeLoading,
      createNoticeError: createNoticeError ?? this.createNoticeError,
      fetchNoticeLoading: fetchNoticeLoading ?? this.fetchNoticeLoading,
      fetchNoticError: fetchNoticError ?? this.fetchNoticError,
      groupNoticeData: groupNoticeData ?? this.groupNoticeData,
      updateNoticeLoading: updateNoticeLoading ?? this.updateNoticeLoading,
      updateNoticeError: updateNoticeError ?? this.updateNoticeError,
      fetchmembersLoading: fetchmembersLoading ?? this.fetchmembersLoading,
      fetchMembersError: fetchMembersError ?? this.fetchMembersError,
      groupMembersList: groupMembersList ?? this.groupMembersList,
      attachedFilePathsList: attachedFilePathsList ?? this.attachedFilePathsList,
      uploadNotesLoading: uploadNotesLoading ?? this.uploadNotesLoading,
      getGroupNotesLoading: getGroupNotesLoading ?? this.getGroupNotesLoading,
      groupNotesError: groupNotesError ?? this.groupNotesError,
      groupNotesMaterialdata: groupNotesMaterialdata ?? this.groupNotesMaterialdata,
      fetchUserConatcsLoading: fetchUserConatcsLoading ?? this.fetchUserConatcsLoading,
      userContactsData: userContactsData ?? this.userContactsData,
      letterIndexMapForContacts: letterIndexMapForContacts ?? this.letterIndexMapForContacts,
      checkStudentInviteLoading: checkStudentInviteLoading ?? this.checkStudentInviteLoading,
      inviteErrorMsg: inviteErrorMsg ?? this.inviteErrorMsg,
      checkStudentBeforeInviteData: checkStudentBeforeInviteData ?? this.checkStudentBeforeInviteData,
      inviteTappedIndex: inviteTappedIndex ?? this.inviteTappedIndex,
      deleteNotesLoading: deleteNotesLoading ?? this.deleteNotesLoading,
      deleteNotesError: deleteNotesError ?? this.deleteNotesError,
      deleteNotesIndex: deleteNotesIndex ?? this.deleteNotesIndex,
    );
  }
}
