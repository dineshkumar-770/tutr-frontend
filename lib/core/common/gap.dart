import 'package:flutter/material.dart';

class Gaps {
  static Widget verticalGap({required double value}) {
    return SizedBox(
      height: value,
    );
  }

  static Widget horizontalGap({required double value}) {
    return SizedBox(
      width: value,
    );
  }
}
