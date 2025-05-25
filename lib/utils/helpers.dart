// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutr_frontend/constants/constant_strings.dart';
import 'package:tutr_frontend/core/singletons/shared_prefs.dart';

class Helper {
  String formatTimeFronUnixTimeStamp(int time) {
    return DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
  }

  String formatDateinDDMMYYYY(DateTime date) {
    return DateFormat("dd-MM-yyyy").format(date);
  }

  String formatDateinDDMMMYYYY(DateTime date) {
    return DateFormat("dd MMM, yyyy hh:mm a").format(date);
  }

  String formatTimeFromMinutes(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    int seconds = 0;
    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  Future<bool> requestStoragePermission(BuildContext context) async {
    if (!Platform.isAndroid) return true; // iOS me storage permission nahi hoti

    bool isGranted = false;

    if (await _isAndroid11OrAbove()) {
      if (await Permission.manageExternalStorage.isGranted) {
        isGranted = true;
      } else {
        PermissionStatus status = await Permission.manageExternalStorage.request();
        final photoReq = await Permission.photos.request();
        final videoReq = await Permission.videos.request();
        final mediaReq = await Permission.mediaLibrary.request();
        // isGranted = status.isGranted;
        if (photoReq.isGranted && videoReq.isGranted && mediaReq.isGranted && status.isGranted) {
          isGranted = true;
        }
      }
    } else {
      if (await Permission.storage.isGranted) {
        isGranted = true;
      } else {
        PermissionStatus status = await Permission.storage.request();
        isGranted = status.isGranted;
      }
    }

    // If permission is denied, ask user to open settings
    if (!isGranted) {
      bool openSettings = await _showPermissionDialog(context);
      if (openSettings) {
        await openAppSettings();
      }
    }

    return isGranted;
  }

// Function to check if Android version is 11+
  Future<bool> _isAndroid11OrAbove() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    if (androidInfo.version.sdkInt >= 30) {
      return true;
    } else {
      return false;
    }
  }

// Show permission denied dialog
  Future<bool> _showPermissionDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Storage Permission Required"),
            content: Text("This app needs storage access to function properly. Please allow access in settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Open Settings"),
              ),
            ],
          ),
        ) ??
        false;
  }

  bool isPdf(String url) {
    return Uri.parse(url).path.toLowerCase().endsWith('.pdf');
  }

  bool isImage(String url) {
    return ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp']
        .any((ext) => Uri.parse(url).path.toLowerCase().endsWith(ext));
  }

  String? sanitizePhoneNumber(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'\D'), '');

    String cleaned = digitsOnly;
    if (cleaned.startsWith('91') && cleaned.length == 12) {
      cleaned = cleaned.substring(2);
    } else if (cleaned.startsWith('0') && cleaned.length == 11) {
      cleaned = cleaned.substring(1);
    }
    if (cleaned.length == 10 && RegExp(r'^[6-9]\d{9}$').hasMatch(cleaned)) {
      return cleaned;
    }
    return null;
  }

  List<String> sanitizePhoneNumberList(String commaSeperatedNumbers) {
    List<String> numbersList = commaSeperatedNumbers.split(",");
    List<String> sanitizedList = [];
    for (var number in numbersList) {
      final sanitizedNum = sanitizePhoneNumber(number);
      if (sanitizedNum != null) {
        sanitizedList.add(sanitizedNum);
      }
    }
    return sanitizedList.toSet().toList();
  }

  S3URLType extractMediaTypeFromUrl(String url) {
    try {
      final mainURL = url.split("?").toList()[0];
      final extractExtension = mainURL.split("/");
      if (extractExtension.last.contains("jpg") ||
          extractExtension.last.contains("jpeg") ||
          extractExtension.last.contains("png") ||
          extractExtension.contains("webp")) {
        return S3URLType.IMAGE;
      } else if (extractExtension.last.contains("pdf")) {
        return S3URLType.PDF;
      } else if (extractExtension.last.contains("mp4")) {
        return S3URLType.VIDEO;
      } else {
        return S3URLType.NIL;
      }
    } catch (e) {
      return S3URLType.NIL;
    }
  }

  String getUserType() {
    final userType = Prefs.getString(ConstantStrings.userType);
    switch (userType.toLowerCase()) {
      case "student":
        return ConstantStrings.student;

      case "teacher":
        return ConstantStrings.teacher;
      default:
        return "";
    }
  }
}

enum S3URLType { PDF, IMAGE, VIDEO, NIL }
