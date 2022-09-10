import 'package:flutter/material.dart';

import 'screens/config/config_screen.dart';
import 'screens/model_form/list_models_screen.dart';
import 'screens/entries/moldel_detail_screen.dart';

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
      home: ListModelsScreen(),
      routes: {
        ListModelsScreen.routeName: (ctx) => ListModelsScreen(),
        ConfigScreen.routeName: (_) => ConfigScreen(),
        ModelDetailScreen.routeName: (_) => ModelDetailScreen(),
      },
    );
  }
}
