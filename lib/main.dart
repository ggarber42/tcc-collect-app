import 'package:flutter/material.dart';

import '../screens/models_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const appTitle = 'Collect-app';
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ModelsScreen(appTitle)
    );
  }
}
