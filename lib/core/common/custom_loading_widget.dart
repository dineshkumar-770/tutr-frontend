// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    this.color,
  });
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(color: color,)
          : Platform.isIOS
              ? CupertinoActivityIndicator(
                  animating: true,
                  radius: 15,
                  color: color,
                )
              : CircularProgressIndicator(color: color,),
    );
  }
}
