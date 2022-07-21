import 'package:flutter/material.dart';

class MainBar extends StatelessWidget with PreferredSizeWidget {
  String windowTitle;

  MainBar({this.windowTitle = 'Collect-app'});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(windowTitle),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
