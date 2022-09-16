import 'package:collect_app/providers/new_entries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/entries/list_entries.dart';
import 'screens/config/config_screen.dart';
import 'screens/model_form/list_models_screen.dart';
import 'utils/arguments.dart';
import 'utils/db_helper.dart';

void main() {
  runApp(MyApp());
}
//tornas as querys de colunas dinamicas

class MyApp extends StatefulWidget {
  static const appTitle = 'Collect-app';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // DataBaseHelper.dropTables();
    DataBaseHelper.initTables();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NewEntries(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyApp.appTitle,
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
      ),
    );
  }
}
