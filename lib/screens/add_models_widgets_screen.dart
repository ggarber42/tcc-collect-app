import 'package:flutter/material.dart';

import '../widgets/main_bar.dart';
import '../widgets/main_drawer.dart';

class AddModelsWidgetScreen extends StatelessWidget {
  static const routeName = '/add-fields';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Add Fields')],
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}