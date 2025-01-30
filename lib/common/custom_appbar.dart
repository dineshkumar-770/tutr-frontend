import 'dart:io';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.appBar,
      required this.title,
      this.useWidgetOnTitle,
      this.actions,
      this.centerTitle,
      this.leadingWidget,
      this.titleWidget});
  final AppBar appBar;
  final String title;
  final bool? useWidgetOnTitle;
  final Widget? titleWidget;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: centerTitle,
        actions: actions,
        automaticallyImplyLeading: false,
        leading: leadingWidget ??
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new)),
        title: (useWidgetOnTitle ?? false)
            ? titleWidget
            : Text(
                title,
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ));
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
