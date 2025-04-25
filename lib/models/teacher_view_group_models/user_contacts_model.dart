// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:azlistview/azlistview.dart';

class UserContactsData extends ISuspensionBean{
  String name;
  String phoneNumber;
  String tag;
  Uint8List? profilePic;

  UserContactsData({
    required this.name,
    required this.phoneNumber,
    required this.tag,
    required this.profilePic,
  });
  
  @override
  String getSuspensionTag() => tag;
}
