import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/repository/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:tutr_frontend/core/singletons/http_handler.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';

class ApiCalls {
  Map<String, String> headersWithoutContentType() {
    return {"Accept": "application/json", "Connection": "keep-alive"};
  }

  Map<String, String> headersWithContentType() {
    return {"Accept": "application/json", "Connection": "keep-alive", "Content-Type": "application/json"};
  }

  Map<String, String> headersWithToken() {
    final token = Prefs.getString(ConstantStrings.userToken);
    if (token.isEmpty) {
      return headersWithoutContentType();
    } else {
      final userToken = "Bearer $token";
      return {"Accept": "application/json", "Connection": "keep-alive", "Authorization": userToken};
    }
  }

  Future<Either<Map<String, dynamic>, String>> sentOTPToEmail({
    required String email,
    required String loginType,
  }) async {
    try {
      String endpoint = ApiEndpoints.sendOTPEmail;
      Map<String, dynamic> formValue = {"login_type": loginType, "email": email};
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: formValue, headers: headersWithoutContentType());
      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> verifyEmailOTP(
      {required String otp, required String email, required String loginType}) async {
    try {
      String endpoint = ApiEndpoints.verifyOTP;
      Map<String, dynamic> formValues = {"otp": otp, "email": email, "login_type": loginType};
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: formValues, headers: headersWithoutContentType());

      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> registerTeacher({
    required String email,
    required String name,
    required String personalContect,
    required String subject,
    required String qualifications,
    required int exprience,
    required String address,
    required String classAssigned,
    required String teacherCode,
  }) async {
    try {
      String endpoint = ApiEndpoints.registerTeacher;
      Map<String, dynamic> formValue = {
        "teacher_id": "",
        "full_name": name,
        "email": email,
        "contact_number": int.parse(personalContect),
        "subject": subject,
        "created_at": 0,
        "qualification": qualifications,
        "experience_years": exprience,
        "address": address,
        "class_assigned": classAssigned,
        "teacher_code": teacherCode
      };
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: jsonEncode(formValue), headers: headersWithContentType());
      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> resgiterStudent({
    required String email,
    required String name,
    required String personalContect,
    required String address,
    required String classAssigned,
    required String parentsContact,
  }) async {
    try {
      String endpoint = ApiEndpoints.registerStudent;
      Map<String, dynamic> formValue = {
        "student_id": "",
        "full_name": name,
        "email": email,
        "created_at": 0,
        "password": "",
        "contact_number": int.parse(personalContect),
        "class": classAssigned,
        "teacher_code": "",
        "parents_contact": int.parse(parentsContact),
        "full_address": address
      };
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: jsonEncode(formValue), headers: headersWithContentType());
      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> getStudentTeachersGroups() async {
    try {
      String endpoint = ApiEndpoints.getTeacherStudentGroups;
      http.Response apiResponse = await HttpHelper.requestGET(url: endpoint, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> fetchUserProfileData() async {
    try {
      String endpoint = ApiEndpoints.getUserProfile;
      http.Response apiResponse = await HttpHelper.requestGET(url: endpoint, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> createGroupTeacher({
    required String groupClass,
    required String groupName,
    required String groupDescription,
  }) async {
    try {
      String endpoint = ApiEndpoints.createGroup;
      Map<String, String> formData = {
        "group_class": groupClass,
        "group_name": groupName,
        "group_desc": groupDescription
      };
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: headersWithToken());

      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> createNoticeForGroup({
    required String groupId,
    required String noticeTitle,
    required String noticeDesc,
  }) async {
    try {
      String endpoint = ApiEndpoints.createGroupNotice;
      Map<String, dynamic> formData = {"group_id": groupId, "title": noticeTitle, "desc": noticeDesc};
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> getGroupNotices({
    required String groupId,
  }) async {
    try {
      String endpoint = ApiEndpoints.getGroupNotice;
      Map<String, dynamic> formData = {
        "group_id": groupId,
      };
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> updateCurrentNoticeBoard(
      {required String groupId,
      required String noticeTitle,
      required String noticeDesc,
      required String noticeId}) async {
    try {
      String endpoint = ApiEndpoints.updateNotice;
      Map<String, dynamic> formData = {
        "group_id": groupId,
        "notice_id": noticeId,
        "new_desc": noticeDesc,
        "new_title": noticeTitle
      };
      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> getGroupMembersTeacher({required String groupId}) async {
    try {
      String endpoint = "${ApiEndpoints.getGroupMembers}?group_id=$groupId";

      http.Response apiResponse = await HttpHelper.requestGET(url: endpoint, headers: headersWithToken());

      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> saveGroupMaterialNotes(
      {required String notesTitle,
      required String notesDescription,
      required String className,
      required String notesTopic,
      required String subject,
      required String visiblity,
      required String groupId,
      required String isEditable,
      required List<String> filePaths}) async {
    try {
      String endpoint = ApiEndpoints.uploadGroupMaterial;
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
      request.fields.addAll({
        'notes_title': notesTitle,
        'notes_desc': notesDescription,
        'class': className,
        'notes_topic': notesTopic,
        'subject': subject,
        'visibility': visiblity,
        'is_editable': isEditable,
        'group_id': groupId
      });

      for (String path in filePaths) {
        request.files.add(await http.MultipartFile.fromPath('notes', path));
      }
      request.headers.addAll(headersWithToken());
      http.StreamedResponse response = await request.send();

      // Read the response stream only once
      final resp = await response.stream.bytesToString();
      log(resp); // Use the already fetched response instead of calling .bytesToString() again

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(resp);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(resp);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          log(response.reasonPhrase.toString());
          return right("${response.reasonPhrase}. Error code ${response.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> getGroupNotesMaterial({required String groupId}) async {
    try {
      String endpoint = "${ApiEndpoints.getGroupMaterialNotes}?group_id=$groupId";
      http.Response apiResponse = await HttpHelper.requestGET(url: endpoint, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> deleteGroupNotes({
    required String notesId,
    required String groupId,
    required String notesTitle,
    required String reason,
    required String notesDescription,
    required String filesUrl,
  }) async {
    try {
      String endpoint = ApiEndpoints.deleteGroupNotes;
      Map<String, dynamic> formData = {
        "deleted_notes_id": notesId,
        "group_id": groupId,
        "notes_title": notesTitle,
        "reason": reason,
        "notes_description": notesDescription,
        "file_urls": filesUrl
      };

      http.Response apiResponse =
          await HttpHelper.requestDELETE(url: endpoint, body: jsonEncode(formData), headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> checkStudentBeforeInvite({required String phoneNumber}) async {
    try {
      String endpoint = "${ApiEndpoints.checkStudentExist}?phone_number=$phoneNumber";

      http.Response apiResponse = await HttpHelper.requestGET(url: endpoint, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> addStudentToTeacherGrp({
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
  }) async {
    try {
      String endpoint = ApiEndpoints.addStudentToGroup;
      Map<String, dynamic> formValue = {
        "owner_name": ownerName,
        "group_id": groupId,
        "student_id": studentId,
        "full_name": fullName,
        "email": studentEmail,
        "created_at": createdAt,
        "contact_number": contactNum,
        "class": className,
        "parents_contact": parentsContact,
        "full_address": address
      };

      http.Response apiResponse =
          await HttpHelper.requrestPOST(url: endpoint, body: jsonEncode(formValue), headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  Future<Either<Map<String, dynamic>, String>> getStudentAttendance(
      {required String groupId, required int count, required int pageNumber}) async {
    try {
      String endpoint = "${ApiEndpoints.takeStudentAttendance}?group_id=$groupId&count=$count&page=$pageNumber";

      http.Response apiResponse = await HttpHelper.requestGET(url: endpoint, headers: headersWithToken());
      if (apiResponse.statusCode == 200) {
        log(apiResponse.body);
        final decodedData = jsonDecode(apiResponse.body);
        return left(decodedData);
      } else {
        try {
          final errorDecoded = jsonDecode(apiResponse.body);
          final errorMessage = errorDecoded["message"].toString();
          return right(errorMessage);
        } catch (e) {
          return right("Internal Server Error. Error code ${apiResponse.statusCode}");
        }
      }
    } catch (e) {
      return right(e.toString());
    }
  }
}
