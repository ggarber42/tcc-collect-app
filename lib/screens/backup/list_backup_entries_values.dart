import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/arguments.dart';
import 'list_entries.dart';
import '../auth/login.dart';
import '../../facades/firestore.dart';
import '../../models/backup_model.dart';
import '../../models/entry.dart';
import '../../models/entry_value.dart';
import '../../providers/auth_firebase.dart';
import '../../widgets/base_widgets/error_warning.dart';
import '../../widgets/custom_widgets/main_bottom.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import 'list_image_files.dart';

class ListBackupValuesScreen extends StatefulWidget {
  static const routeName = '/list-backup';
  const ListBackupValuesScreen({Key? key}) : super(key: key);

  @override
  State<ListBackupValuesScreen> createState() => _ListBackupValuesScreenState();
}

class _ListBackupValuesScreenState extends State<ListBackupValuesScreen> {
  final fireFacade = FirestoreFacade();

  List<dynamic> _setBackupModels(results) {
    final modelMap = {};
    for (var result in results) {
      final data = result['data'];
      modelMap.putIfAbsent(
        data['modelName'],
        () => BackupModel.onlyName(modelName: data['modelName']),
      );
      final entryName = data['name'];
      final values = data['values'] as List;
      final entryValues = values
          .map(
            (value) => EntryValue.fromField(value['name'], value['value']),
          )
          .toList();
      final entry = Entry.fromFirestore(
        entryName,
        entryValues,
        result['docId'],
      );
      for (var model in modelMap.values) {
        if (model.getModelName == data['modelName']) {
          if (model.getEntries != null) {
            var newEntries = <Entry>[];
            newEntries = [...model.getEntries, entry];
            model.setEntries = newEntries;
          } else {
            model.setEntries = [entry];
          }
        }
      }
    }
    return modelMap.values.toList();
  }

  Widget _notAuthWarning() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Você não está logado',
            style: TextStyle(fontSize: 25),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Text('Faça o login aqui'),
          )
        ],
      ),
    );
  }

  Widget _imageTile(String userId) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.image),
        title: Text('Imagens'),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.pushNamed(
            context,
            ListImageFielsScreen.routeName,
            arguments: ListImageFilesArguments(userId),
          );
        },
      ),
    );
  }

  Widget _listModels(String userId) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: fireFacade.readBackupValues(userId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final modelList = _setBackupModels(snapshot.data);
          return Column(
            children: [
              _imageTile(userId),
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: modelList.length,
                  itemBuilder: ((context, index) => Card(
                        child: ListTile(
                          title: Text(modelList[index].getModelName),
                          trailing: Icon(Icons.more_vert),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ListBackupEntriesScreen(
                                      modelList[index].getModelName,
                                      modelList[index].getEntries,
                                    )),
                              ),
                            );
                          },
                        ),
                      )),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorWarning();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.getUserId();
    return Scaffold(
      appBar: MainBar(),
      body: (userId == null) ? _notAuthWarning() : _listModels(userId),
      bottomNavigationBar: MainBottom(currentIndex: 2),
    );
  }
}
