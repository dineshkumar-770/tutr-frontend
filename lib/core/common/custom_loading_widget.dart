import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator()
          : Platform.isIOS
              ? CupertinoActivityIndicator(
                  animating: true,
                  radius: 15,
                )
              : CircularProgressIndicator(),
    );
  }
}
