import 'package:flutter/material.dart';

class MainBar extends StatelessWidget with PreferredSizeWidget {
  final String windowTitle;
  final bool hasBackButton;
  final bool hasShareAction;
  final bool hasBackup;
  final bool hasDeleteAction;
  VoidCallback? shareFunction;
  VoidCallback? backupFunction;
  VoidCallback? deleteFunction;
  Function? clickHandler;

  MainBar(
      {this.windowTitle = 'Collect-app',
      this.hasBackButton = false,
      this.clickHandler,
      this.hasShareAction = false,
      this.hasBackup = false,
      this.hasDeleteAction = false,
      this.shareFunction,
      this.deleteFunction,
      this.backupFunction});

  List<Widget>? _actions() {
    var actions = <Widget>[];
    if (hasShareAction) {
      actions.add(
        IconButton(
          onPressed: shareFunction,
          icon: Icon(Icons.share),
        ),
      );
    }
    if (hasBackup) {
      actions.add(
        IconButton(
          onPressed: backupFunction,
          icon: Icon(Icons.backup),
        ),
      );
    }
    if(hasDeleteAction){
      actions.add(
        IconButton(
          onPressed: deleteFunction,
          icon: Icon(Icons.delete),
        ),
      );
    }
    return actions;
  }

  Widget _backButton(context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hasBackButton) {
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
