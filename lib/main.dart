import 'package:collect_app/screens/backup/list_backup_entries_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'providers/form_models.dart';
import 'screens/config/config_screen.dart';
import 'screens/entries/entry_results.dart';
import '/screens/entries/entry_result_image.dart';
import 'screens/entries/entry_result_values.dart';
import 'screens/entries/list_entries.dart';
import 'screens/model_form/list_form_model.dart';
import 'utils/arguments.dart';
import 'utils/db_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // DataBaseHelper.dropTables();
    DataBaseHelper.initTables();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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
          ListBackupValuesScreen.routeName: (_) => ListBackupValuesScreen(),
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
          if (settings.name == EntryResultScreen.routeName) {
            final args = settings.arguments as EntryResultsArguments;
            return MaterialPageRoute(builder: (context) {
              return EntryResultScreen(
                args.entryId,
                args.entryName
              );
            });
          }
          if (settings.name == EntryValuesResultScreen.routeName) {
            final args = settings.arguments as EntryValuesArguments;
            return MaterialPageRoute(builder: (context) {
              return EntryValuesResultScreen(
                args.values,
                args.shareValues,
                args.backupEntryValues
              );
            });
          }
          if (settings.name == EntryResultImageScreen.routeName) {
            final args = settings.arguments as EntryImageArguments;
            return MaterialPageRoute(builder: (context) {
              return EntryResultImageScreen(
                args.image,
                args.shareValues
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
