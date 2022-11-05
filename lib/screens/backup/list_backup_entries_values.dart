import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/entry_value.dart';
import '../../models/entry_value_collection.dart';
import '../../facades/firestore.dart';
import '../../providers/auth_firebase.dart';
import '../../widgets/custom_widgets/main_bottom.dart';
import '../../widgets/custom_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/collection_tile.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../auth/login.dart';

class ListBackupValuesScreen extends StatefulWidget {
  static const routeName = '/list-backup';
  const ListBackupValuesScreen({Key? key}) : super(key: key);

  @override
  State<ListBackupValuesScreen> createState() => _ListBackupValuesScreenState();
}

class _ListBackupValuesScreenState extends State<ListBackupValuesScreen> {
  final fireFacade = FirestoreFacade();

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

  Widget _listBackups(String userId) {
    return StreamBuilder(
      stream: fireFacade.readBackupValues(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as List;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, i) {
                List<EntryValue> entryValues = [];
                for (var entry in data[i]['data']['values']) {
                  entryValues.add(
                    EntryValue.fromField(entry['name'], entry['value']),
                  );
                }
                final collection = EntryValueCollection.fromFireBase(
                  docId: data[i]['docId'],
                  entryName: data[i]['data']['name'],
                  values: entryValues,
                );
                return CollectionTile(i, data[i]['docId'], userId, collection);
              });
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            'Algo deu errado :(',
            style: TextStyle(fontSize: 25),
          ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.getUserId();
    return Scaffold(
      appBar: MainBar(),
      drawer: MainDrawer(),
      body: (userId == null) ? _notAuthWarning() : _listBackups(userId),
      bottomNavigationBar: MainBottom(currentIndex: 2),
    );
  }
}