import 'dart:convert';

import 'package:tutr/common/constants/constant_strings.dart';
import 'package:tutr/routes/api_endpoints.dart';
import 'package:tutr/utils/api_result.dart';

import 'package:http/http.dart' as http;
import 'package:tutr/core/singletons/http_singelton.dart';

class ApiCalls {
  Result evaluateResponse(http.Response apiResponse) {
    if (apiResponse.statusCode == 200) {
      if (apiResponse.body.toString().isNotEmpty) {
        return Result<String>.success(apiResponse.body);
      } else {
        return Result.error("Response has No JSON Body");
      }
    } else if (apiResponse.statusCode == 400) {
      return Result<String>.error(ConstantStrings.serverError);
    } else if (apiResponse.statusCode == 404) {
      return Result<String>.error(ConstantStrings.serverError);
    } else if (apiResponse.statusCode == 500) {
      return Result<String>.error(ConstantStrings.serverError);
    } else if (apiResponse.statusCode == 502) {
      return Result<String>.error(ConstantStrings.serverError);
    } else if (apiResponse.statusCode == 502) {
      return Result<String>.error(ConstantStrings.serverError);
    } else if (apiResponse.statusCode == 413) {
      return Result<String>.error(ConstantStrings.serverError);
    } else {
      return Result<String>.error("Something went wrong .Error code is ${apiResponse.statusCode}");
    }
  }

  Map<String, String> headers() {
    return {"Content-Type": "application/json", "Accept": "application/json", "Connection": "keep-alive"};
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
}
