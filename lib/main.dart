import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/form_models.dart';
import 'screens/entries/list_entries.dart';
import 'screens/config/config_screen.dart';
import 'screens/entries/entry_detail.dart';
import 'screens/model_form/list_form_model.dart';
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
          create: (ctx) => FormModels(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyApp.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ListFormModelsScreen(),
        routes: {
          ListFormModelsScreen.routeName: (ctx) => ListFormModelsScreen(),
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
          if (settings.name == EntryDetailScreen.routeName) {
            final args = settings.arguments as EntryArguments;
            return MaterialPageRoute(builder: (context) {
              return EntryDetailScreen(
                args.entryId,
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
