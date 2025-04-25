import 'dart:developer';
import 'dart:isolate';

import 'package:azlistview/azlistview.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:toastification/toastification.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/common/custom_toast.dart';
import 'package:tutr_frontend/core/di/locator_di.dart';
import 'package:tutr_frontend/core/repository/api_calls.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/check_stduent_brfore_invite.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/group_material_notes_model.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/group_members_model.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/group_notice_model.dart';
import 'package:tutr_frontend/models/teacher_view_group_models/user_contacts_model.dart';
import 'package:tutr_frontend/utils/helpers.dart';

part 'teacher_view_group_event.dart';
part 'teacher_view_group_state.dart';

class TeacherViewGroupBloc extends Bloc<TeacherViewGroupEvent, TeacherViewGroupState> {
  TeacherViewGroupBloc() : super(TeacherViewGroupState.init()) {
    on<CreateNoticeForGroupEvent>(createNoticeGroup);
    on<FetchNoticeForGroupEvent>(fetchNoticeOfGroup);
    on<UpdateNoticeBoardEvent>(updateCurrentNotice);
    on<FetchGroupMembersEvent>(fetchMembersGroup);
    on<AttachClassMaterialEvent>(pickClassMaterialAttachments);
    on<UpdateAttachmentsEvent>(updateAttachments);
    on<UploadGroupMaterialEvent>(uploadGroupMaterialNotes);
    on<FetchGroupMaterialNotes>(fetchGroupNotes);
    on<FetchuserContactsListEvent>(fetchLargeContacts);
    on<CheckBeforeInviteStudentEvent>(checkStudentExistBeforeInvite);
    on<DeleteClassMaterialEvent>(deleteClassMaterialNotes);
  }

  final ApiCalls _apiCalls = locatorDI<ApiCalls>();
  final Helper _helper = locatorDI<Helper>();
  Future<void> createNoticeGroup(CreateNoticeForGroupEvent event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(createNoticeLoading: true, createNoticeError: ""));

    final response = await _apiCalls.createNoticeForGroup(
      groupId: event.groupId,
      noticeTitle: event.title,
      noticeDesc: event.description,
    );

    response.fold(
      (data) {
        final String message = data["message"].toString();
        final bool isSuccess = data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase();

        emit(state.copyWith(
          createNoticeLoading: false,
          createNoticeError: isSuccess ? "" : message,
        ));

        CustomToast.show(
          toastType: isSuccess ? ToastificationType.success : ToastificationType.error,
          context: event.context,
          title: message,
        );

        add(FetchNoticeForGroupEvent(context: event.context, groupId: event.groupId));
      },
      (error) {
        emit(state.copyWith(createNoticeLoading: false, createNoticeError: error.toString()));

        CustomToast.show(
          toastType: ToastificationType.error,
          context: event.context,
          title: error.toString(),
        );
      },
    );
  }

  Future<void> fetchNoticeOfGroup(FetchNoticeForGroupEvent event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(fetchNoticeLoading: true, fetchNoticError: "", groupNoticeData: GroupNoticeModel()));

    final response = await _apiCalls.getGroupNotices(groupId: event.groupId);

    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          final groupNoticeModel = GroupNoticeModel.fromJson(data);
          emit(state.copyWith(fetchNoticeLoading: false, groupNoticeData: groupNoticeModel));
          CustomToast.show(
            toastType: ToastificationType.success,
            context: event.context,
            title: data["message"].toString(),
          );
        } else {
          emit(state.copyWith(fetchNoticeLoading: false, fetchNoticError: data["message"].toString()));
          CustomToast.show(
            toastType: ToastificationType.warning,
            context: event.context,
            title: data["message"].toString(),
          );
        }
      },
      (err) {
        emit(state.copyWith(fetchNoticeLoading: false, fetchNoticError: err.toString()));
        CustomToast.show(
          toastType: ToastificationType.error,
          context: event.context,
          title: err.toString(),
        );
      },
    );
  }

  Future<void> updateCurrentNotice(UpdateNoticeBoardEvent event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(updateNoticeLoading: true, updateNoticeError: ""));
    final response = await _apiCalls.updateCurrentNoticeBoard(
        groupId: event.groupId, noticeTitle: event.noticeTitle, noticeDesc: event.noticeDesc, noticeId: event.noticeId);

    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          emit(state.copyWith(updateNoticeError: "", updateNoticeLoading: false));
          CustomToast.show(
              toastType: ToastificationType.success, context: event.context, title: data["message"].toString());
          add(FetchNoticeForGroupEvent(context: event.context, groupId: event.groupId));
        } else {
          emit(state.copyWith(updateNoticeError: data["message"].toString(), updateNoticeLoading: false));
          CustomToast.show(
              toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
        }
      },
      (err) {
        emit(state.copyWith(updateNoticeError: err, updateNoticeLoading: false));
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: err);
      },
    );
  }

  Future<void> fetchMembersGroup(FetchGroupMembersEvent event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(fetchmembersLoading: true, groupMembersList: [], fetchMembersError: ""));
    final response = await _apiCalls.getGroupMembersTeacher(groupId: event.groupId);

    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          try {
            GroupMemberModel groupMemberModel = GroupMemberModel.fromJson(data);
            if (groupMemberModel.response != null && (groupMemberModel.response?.isNotEmpty ?? false)) {
              emit(state.copyWith(
                  fetchMembersError: "", fetchmembersLoading: false, groupMembersList: groupMemberModel.response));
            }
          } catch (e) {
            emit(state.copyWith(fetchMembersError: e.toString(), fetchmembersLoading: false, groupMembersList: []));
            CustomToast.show(toastType: ToastificationType.error, context: event.context, title: e.toString());
          }
        } else {
          emit(state.copyWith(
              fetchMembersError: data["message"] ?? "No group members available",
              fetchmembersLoading: false,
              groupMembersList: []));
          CustomToast.show(
              toastType: ToastificationType.error,
              context: event.context,
              title: data["message"] ?? "No group members available");
        }
      },
      (err) {
        emit(state.copyWith(fetchMembersError: err, fetchmembersLoading: false, groupMembersList: []));
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: err);
      },
    );
  }

  Future<void> pickClassMaterialAttachments(AttachClassMaterialEvent event, Emitter<TeacherViewGroupState> emit) async {
    final isGranded = await _helper.requestStoragePermission(event.context);
    if (isGranded) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: true, allowedExtensions: ["jpg", "pdf", "mp4"], type: FileType.custom);

      if (result != null) {
        if (result.files.length > 10) {
          if (event.context.mounted) {
            CustomToast.show(
                toastType: ToastificationType.info,
                context: event.context,
                title: "You can only pick 10 files at a time!");
            return;
          }
        }
        List<String> filePathsList = List.from(state.attachedFilePathsList);

        for (PlatformFile file in result.files) {
          filePathsList.add(file.path ?? "");
        }

        emit(state.copyWith(attachedFilePathsList: filePathsList));
      } else {
        if (event.context.mounted) {
          CustomToast.show(
              toastType: ToastificationType.info, context: event.context, title: "NO file content is picked by user");
        }
      }
    } else {
      if (event.context.mounted) {
        CustomToast.show(
            toastType: ToastificationType.warning,
            context: event.context,
            title: "Storage permission denied. Kindly open the settings and allow the required permission.");
      }
    }
  }

  void updateAttachments(UpdateAttachmentsEvent event, Emitter<TeacherViewGroupState> emit) {
    List<String> listOfCurrentPaths = List.from(state.attachedFilePathsList);

    if (listOfCurrentPaths.contains(event.selectedFilePath)) {
      listOfCurrentPaths.remove(event.selectedFilePath);
    }
    emit(state.copyWith(attachedFilePathsList: listOfCurrentPaths));
  }

  Future<void> uploadGroupMaterialNotes(UploadGroupMaterialEvent event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(uploadNotesLoading: true));
    final response = await _apiCalls.saveGroupMaterialNotes(
        notesTitle: event.notesTitle,
        notesDescription: event.notesDescription,
        className: event.className,
        notesTopic: event.notesTopic,
        subject: event.subject,
        visiblity: event.visiblity,
        groupId: event.groupId,
        isEditable: event.isEditable,
        filePaths: state.attachedFilePathsList);

    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          emit(state.copyWith(uploadNotesLoading: false));
          CustomToast.show(
              toastType: ToastificationType.success, context: event.context, title: data["message"].toString());
        } else {
          emit(state.copyWith(uploadNotesLoading: false));
          CustomToast.show(
              toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
        }
      },
      (error) {
        emit(state.copyWith(uploadNotesLoading: false));
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: error);
      },
    );
  }

  Future<void> fetchGroupNotes(FetchGroupMaterialNotes event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(getGroupNotesLoading: true, groupNotesError: ""));

    final response = await _apiCalls.getGroupNotesMaterial(groupId: event.groupId);

    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          try {
            GroupNotesMaterialModel groupNotesMaterialModel = GroupNotesMaterialModel.fromJson(data);
            if (groupNotesMaterialModel.status?.toLowerCase() == ConstantStrings.success.toLowerCase()) {
              List<StudyMaterial> listOfNotesMaterial = groupNotesMaterialModel.response ?? [];
              listOfNotesMaterial.sort((a, b) => (b.uploadedAt ?? 0).compareTo(a.uploadedAt ?? 0));
              emit(state.copyWith(
                  groupNotesError: "", getGroupNotesLoading: false, groupNotesMaterialdata: listOfNotesMaterial));
              CustomToast.show(
                  toastType: ToastificationType.success, context: event.context, title: data["message"].toString());
            } else {
              emit(state.copyWith(
                groupNotesError: data["message"].toString(),
                getGroupNotesLoading: false,
              ));
              CustomToast.show(
                  toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
            }
          } catch (e) {
            emit(state.copyWith(groupNotesError: e.toString(), getGroupNotesLoading: false));
            CustomToast.show(toastType: ToastificationType.error, context: event.context, title: e.toString());
          }
        }
      },
      (error) {
        emit(state.copyWith(groupNotesError: error, getGroupNotesLoading: false));
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: error);
      },
    );
  }

  Future<void> fetchLargeContacts(FetchuserContactsListEvent event, Emitter<TeacherViewGroupState> emit) async {
    final contactsPermission = await FlutterContacts.requestPermission();
    if (contactsPermission) {
      try {
        emit(state.copyWith(fetchUserConatcsLoading: true));
        ReceivePort rcPort = ReceivePort();
        var rootToken = RootIsolateToken.instance!;
        await Isolate.spawn(UserContactsList.fetchContacts, [rcPort.sendPort, rootToken]);
        dynamic result = await rcPort.first;
        log(result.toString());
        rcPort.close();
        final indexedMap = _generateLetterIndexMap(result[0] ?? []);
        SuspensionUtil.sortListBySuspensionTag(result[0] ?? []);
        SuspensionUtil.setShowSuspensionStatus(result[0] ?? []);
        emit(state.copyWith(
            fetchUserConatcsLoading: false, userContactsData: result[0] ?? [], letterIndexMapForContacts: indexedMap));

        log(state.userContactsData.toString());
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(fetchUserConatcsLoading: false));
      }
    } else {
      emit(state.copyWith(fetchUserConatcsLoading: false));
      if (event.context.mounted) {
        CustomToast.show(
            toastType: ToastificationType.warning,
            context: event.context,
            title: "Permission denined to access your contacts");
      }
    }
  }

  Map<String, int> _generateLetterIndexMap(List<UserContactsData> contacts) {
    Map<String, int> letterIndexMap = {};
    for (int i = 0; i < contacts.length; i++) {
      final letter = contacts[i].name[0].toUpperCase();
      if (!letterIndexMap.containsKey(letter)) {
        letterIndexMap[letter] = i;
      }
    }
    return letterIndexMap;
  }

  Future<void> checkStudentExistBeforeInvite(
      CheckBeforeInviteStudentEvent event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(checkStudentInviteLoading: true, inviteErrorMsg: "", inviteTappedIndex: event.tappedIndex));
    final response = await _apiCalls.checkStudentBeforeInvite(
      phoneNumber: event.phoneNumber,
    );
    response.fold(
      (data) async {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          CheckStudentBeforeInviteModel checkStudentBeforeInviteModel = CheckStudentBeforeInviteModel.fromJson(data);
          if (checkStudentBeforeInviteModel.response != null &&
              checkStudentBeforeInviteModel.status?.toLowerCase() == ConstantStrings.success.toLowerCase()) {
            final isMemberAdded = await addMemberToGroup(
                ownerName: event.ownerName,
                context: event.context,
                groupId: event.groupId,
                studentId: checkStudentBeforeInviteModel.response?.studentId ?? "",
                fullName: checkStudentBeforeInviteModel.response?.fullName ?? "",
                studentEmail: checkStudentBeforeInviteModel.response?.email ?? "",
                createdAt: checkStudentBeforeInviteModel.response?.createdAt ?? 0,
                contactNum: checkStudentBeforeInviteModel.response?.contactNumber ?? 0,
                className: event.className,
                parentsContact: checkStudentBeforeInviteModel.response?.parentsContact ?? 0,
                address: checkStudentBeforeInviteModel.response?.fullAddress ?? "");

            if (isMemberAdded) {
              if (event.context.mounted) {
                CustomToast.show(
                    toastType: ToastificationType.success,
                    context: event.context,
                    title: "Student Invited Successfully");
              }
              emit(state.copyWith(
                  checkStudentInviteLoading: false,
                  inviteErrorMsg: "",
                  inviteTappedIndex: event.tappedIndex,
                  checkStudentBeforeInviteData: checkStudentBeforeInviteModel));
            } else {
              if (event.context.mounted) {
                CustomToast.show(
                    toastType: ToastificationType.error,
                    context: event.context,
                    title: "Cannot invite person right now");
              }
              emit(state.copyWith(
                  checkStudentInviteLoading: false,
                  inviteErrorMsg: "Cannot invite person right now",
                  inviteTappedIndex: event.tappedIndex,
                  checkStudentBeforeInviteData: checkStudentBeforeInviteModel));
            }
          } else {
            CustomToast.show(
                toastType: ToastificationType.error,
                context: event.context,
                title: checkStudentBeforeInviteModel.message ?? "Something went wrong");
            emit(state.copyWith(
                checkStudentInviteLoading: false,
                inviteTappedIndex: event.tappedIndex,
                inviteErrorMsg: checkStudentBeforeInviteModel.message ?? "Something went wrong",
                checkStudentBeforeInviteData: checkStudentBeforeInviteModel));
          }
        } else {
          CustomToast.show(
              toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
          emit(state.copyWith(
              checkStudentInviteLoading: false,
              inviteErrorMsg: data["message"].toString(),
              inviteTappedIndex: event.tappedIndex,
              checkStudentBeforeInviteData: CheckStudentBeforeInviteModel()));
        }
      },
      (error) {
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: error);
        emit(state.copyWith(
            checkStudentInviteLoading: false,
            inviteErrorMsg: error,
            inviteTappedIndex: event.tappedIndex,
            checkStudentBeforeInviteData: CheckStudentBeforeInviteModel()));
      },
    );
  }

  Future<bool> addMemberToGroup({
    required String ownerName,
    required String groupId,
    required String studentId,
    required String fullName,
    required String studentEmail,
    required int createdAt,
    required int contactNum,
    required String className,
    required int parentsContact,
    required String address,
    required BuildContext context,
  }) async {
    final response = await _apiCalls.addStudentToTeacherGrp(
        ownerName: ownerName,
        groupId: groupId,
        studentId: studentId,
        fullName: fullName,
        studentEmail: studentEmail,
        createdAt: createdAt,
        contactNum: contactNum,
        className: className,
        parentsContact: parentsContact,
        address: address);

    return response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          CustomToast.show(toastType: ToastificationType.success, context: context, title: data["message"].toString());
          return true;
        } else {
          return false;
        }
      },
      (r) => false,
    );
  }

  Future<void> deleteClassMaterialNotes(DeleteClassMaterialEvent event, Emitter<TeacherViewGroupState> emit) async {
    emit(state.copyWith(deleteNotesLoading: true, deleteNotesError: "", deleteNotesIndex: event.selectedNotesIndex));

    final response = await _apiCalls.deleteGroupNotes(
        notesId: event.notesId,
        groupId: event.groupId,
        notesTitle: event.notesTitle,
        reason: event.reason,
        notesDescription: event.notesDescription,
        filesUrl: event.filesUrl);

    response.fold(
      (data) {
        if (data["status"].toString().toLowerCase() == ConstantStrings.success.toLowerCase()) {
          emit(state.copyWith(
              deleteNotesError: "", deleteNotesIndex: event.selectedNotesIndex, deleteNotesLoading: false));
          CustomToast.show(
              toastType: ToastificationType.success, context: event.context, title: data["message"].toString());
          add(FetchGroupMaterialNotes(context: event.context, groupId: event.groupId));
        } else {
          emit(state.copyWith(
              deleteNotesError: data["message"].toString(),
              deleteNotesIndex: event.selectedNotesIndex,
              deleteNotesLoading: false));
          CustomToast.show(
              toastType: ToastificationType.error, context: event.context, title: data["message"].toString());
        }
      },
      (err) {
        emit(state.copyWith(
            deleteNotesError: err, deleteNotesIndex: event.selectedNotesIndex, deleteNotesLoading: false));
        CustomToast.show(toastType: ToastificationType.error, context: event.context, title: err);
      },
    );
  }
}

class UserContactsList {
  static Future<void> fetchContacts(List<dynamic> values) async {
    SendPort port = values[0];
    final token = values[1];
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    final contactsList = await FlutterContacts.getContacts(
        sorted: true,
        withPhoto: true,
        withThumbnail: true,
        withProperties: true,
        deduplicateProperties: false,
        withAccounts: true);
    List<UserContactsData> userContactList = [];
    String commaSepetratedNumberForMultipleContacts = "";
    try {
      for (int i = 0; i < contactsList.length; i++) {
        if (contactsList[i].phones.isNotEmpty) {
          if (contactsList[i].phones.length > 1) {
            List<String> multiNumbrList = [];
            for (var ct in contactsList[i].phones) {
              multiNumbrList.add(ct.number);
            }
            commaSepetratedNumberForMultipleContacts = multiNumbrList.join(",");
          } else {
            commaSepetratedNumberForMultipleContacts = contactsList[i].phones[0].number;
          }
        }

        if (contactsList[i].displayName.isNotEmpty && commaSepetratedNumberForMultipleContacts.isNotEmpty) {
          UserContactsData userContactsData = UserContactsData(name: "", phoneNumber: "", tag: "", profilePic: null);
          userContactsData.name = contactsList[i].displayName;
          userContactsData.phoneNumber = commaSepetratedNumberForMultipleContacts;
          userContactsData.profilePic = contactsList[i].photoOrThumbnail;
          final firstChar =
              contactsList[i].displayName.trim().isNotEmpty ? contactsList[i].displayName.trim()[0].toUpperCase() : "#";
          userContactsData.tag = RegExp(r'^[A-Z]$').hasMatch(firstChar) ? firstChar : "#";

          userContactList.add(userContactsData);
        }
      }
    } catch (e) {
      log(e.toString());
      userContactList = [];
    }
    port.send([userContactList]);
    Isolate.exit(port, [userContactList]);
  }
}
