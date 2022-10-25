import 'package:flutter/material.dart';

class MainBar extends StatelessWidget with PreferredSizeWidget {
  final String windowTitle;
  final bool hasBackButton;
  final bool hasShareAction;
  VoidCallback? shareFunction;
  Function? clickHandler;

  MainBar({
    this.windowTitle = 'Collect-app',
    this.hasBackButton = false,
    this.clickHandler,
    this.hasShareAction = false,
    this.shareFunction,
  });

  List<Widget> _actions() {
    if (hasShareAction) {
      return [
        IconButton(
          onPressed: shareFunction,
          icon: Icon(Icons.share),
        )
      ];
    }
    return [];
  }

  Widget _backButton(context) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      );
  }

  @override
  Widget build(BuildContext context) {
    if(hasBackButton){
      return AppBar(
      title: Text(windowTitle),
      automaticallyImplyLeading: false,
      leading: _backButton(context),
      actions: _actions(),
    );
    }
    return AppBar(
      title: Text(windowTitle),
      actions: _actions(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
