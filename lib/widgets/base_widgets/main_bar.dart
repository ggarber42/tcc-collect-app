import 'package:flutter/material.dart';

class MainBar extends StatelessWidget with PreferredSizeWidget {
  final String windowTitle;
  final bool hasBackButton;

  MainBar({this.windowTitle = 'Collect-app', this.hasBackButton = false});
  @override
  Widget build(BuildContext context) {
    if (hasBackButton) {
      return AppBar(
        title: Text(windowTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      );
    }
    return AppBar(
      title: Text(windowTitle),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
