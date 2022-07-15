import 'package:flutter/material.dart';

class MainBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text('Collect-app'));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
