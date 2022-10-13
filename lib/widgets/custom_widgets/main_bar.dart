import 'package:flutter/material.dart';

class MainBar extends StatelessWidget with PreferredSizeWidget {
  final String windowTitle;
  final bool hasBackButton;
  Function? clickHandler;

  MainBar({
    this.windowTitle = 'Collect-app',
    this.hasBackButton = false,
    this.clickHandler,
  });
  @override
  Widget build(BuildContext context) {
    if (hasBackButton) {
      return AppBar(
        title: Text(windowTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => clickHandler!(),
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
