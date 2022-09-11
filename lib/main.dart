import 'package:flutter/material.dart';

import 'screens/entries/list_entries.dart';
import 'screens/config/config_screen.dart';
import 'screens/model_form/list_models_screen.dart';
import 'utils/arguments.dart';

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
      },
      onGenerateRoute: (settings) {
        if (settings.name == ListEntriesScreen.routeName) {
          final args = settings.arguments as ModelArguments;
          return MaterialPageRoute(builder: (context) {
            return ListEntriesScreen(
              args.modelId,
              args.modelName,
            );
          });
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
