import 'dart:convert';
import 'dart:developer';

import 'package:tutr/resources/constant_strings.dart';
import 'package:tutr/routes/api_endpoints.dart';
import 'package:tutr/service/api_result.dart';

import 'package:http/http.dart' as http;
import 'package:tutr/utils/http_singelton.dart';
import 'package:tutr/utils/shared_prefs.dart';

class ApiCalls {
  Result evaluateResponse(http.Response apiResponse) {
    log("api response=====> :  ${apiResponse.body}");
    if (apiResponse.statusCode == 200) {
      if (apiResponse.body.toString().isNotEmpty) {
        return Result<String>.success(apiResponse.body);
      } else {
        return Result.error("Response has No JSON Body");
      }
    } else if (apiResponse.statusCode == 400) {
      return Result<String>.error(ConstantStrings.serverError);
    } else if (apiResponse.statusCode == 404) {
      if (apiResponse.body.toString().isNotEmpty) {
        final decodedData = jsonDecode(apiResponse.body);
        return Result<String>.error(decodedData["message"].toString());
      } else {
        return Result.error("Response has No JSON Body");
      }
    } else if (apiResponse.statusCode == 500) {
      if (apiResponse.body.toString().isNotEmpty) {
        final decodedData = jsonDecode(apiResponse.body);
        return Result<String>.error(decodedData["message"].toString());
      } else {
        return Result.error("Response has No JSON Body");
      }
    } else if (apiResponse.statusCode == 502) {
      return Result<String>.error(ConstantStrings.serverError);
    } else if (apiResponse.statusCode == 503) {
      if (apiResponse.body.toString().isNotEmpty) {
        final decodedData = jsonDecode(apiResponse.body);
        return Result<String>.error(decodedData["message"].toString());
      } else {
        return Result.error("Response has No JSON Body");
      }
    } else if (apiResponse.statusCode == 413) {
      return Result<String>.error(ConstantStrings.serverError);
    } else {
      return Result<String>.error("Something went wrong .Error code is ${apiResponse.statusCode}");
    }
  }

  Map<String, String> headers() {
    return {
      // "Content-Type": "application/json",
      "Accept": "application/json", "Connection": "keep-alive"
    };
  }

  Map<String, String> addHeadersWithToken() {
    final token = Prefs.getString(ConstantStrings.tokenKey);
    final jwtToken = "Bearer $token";
    log(jwtToken.toString());
    return {"Accept": "application/json", "Connection": "keep-alive", "Authorization": jwtToken};
  }

  Future<Result> registerStudents({
    required String fullName,
    required String email,
    required String studentPhoneNumber,
    required String classroom,
    required String teacherCode,
    required String parentsPhoneNumber,
    required String fullAddress,
  }) async {
    try {
      final endpoint = ApiEndpoints.registerStudent;
      Map<String, dynamic> body = {
        "student_id": "",
        "full_name": fullName,
        "email": email,
        "created_at": 0,
        "password": "",
        "contact_number": int.parse(studentPhoneNumber),
        "class": classroom,
        "teacher_code": teacherCode,
        "parents_contact": int.parse(parentsPhoneNumber),
        "full_address": fullAddress
      };
      final response = await HttpHelper.requrestPOST(url: endpoint, body: jsonEncode(body), headers: headers());
      return evaluateResponse(response);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result> getTeachersList() async {
    try {
      String endpoint = ApiEndpoints.getAllTeachers;
      final response = await HttpHelper.requestGET(url: endpoint, headers: headers());
      return evaluateResponse(response);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result> sendEmailOTP({required String loginType, required String email}) async {
    try {
      String endpoint = ApiEndpoints.sendOTPEmail;
      Map<String, dynamic> formData = {
        "login_type": loginType,
        "email": email,
      };

      final response = await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: headers());
      return evaluateResponse(response);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result> verifyEmailOTP({required String loginType, required String email, required String otp}) async {
    try {
      String endpoint = ApiEndpoints.verifyOTP;
      final formData = {"email": email, "otp": otp, "login_type": loginType};
      final respone = await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: headers());
      return evaluateResponse(respone);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result> getTeacherGroups() async {
    try {
      String endpoint = ApiEndpoints.getTeacherGroups;

      final response = await HttpHelper.requestGET(url: endpoint, headers: addHeadersWithToken());
      return evaluateResponse(response);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result> createGroup({required String className, required String groupTitle, required String groupDescription}) async {
    try {
      String endpoint = ApiEndpoints.createTeacherGroup;
      final formData = {"group_class": className, "group_name": groupTitle, "group_desc": groupDescription};
      final response = await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: addHeadersWithToken());
      return evaluateResponse(response);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result> getGroupNotices({required String groupId}) async {
    try {
      String endpoint = ApiEndpoints.getGroupNotices;
      final formData = {"group_id": groupId};
      final response = await HttpHelper.requrestPOST(url: endpoint, body: formData, headers: addHeadersWithToken());
      return evaluateResponse(response);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
