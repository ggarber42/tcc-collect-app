import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect_app/facades/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/entry_value.dart';
import '../../models/entry_value_collection.dart';
import '../../providers/auth_firebase.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/collection_tile.dart';
import '../../widgets/custom_widgets/field_card.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../utils/constants.dart';

class ListBackupValuesScreen extends StatefulWidget {
  static const routeName = '/list-backup';
  const ListBackupValuesScreen({Key? key}) : super(key: key);

  @override
  State<ListBackupValuesScreen> createState() => _ListBackupValuesScreenState();
}

class _ListBackupValuesScreenState extends State<ListBackupValuesScreen> {
  final fireFacade = FirestoreFacade();
  Stream<List<dynamic>> readValueCollections() => FirebaseFirestore.instance
      .collection(VALUE_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => {'docId': doc.id, 'data': doc.data()})
          .toList());

  Widget titleTile(obj) {
    return FieldCard(children: [
      ListTile(
        leading: Icon(Icons.android),
        title: Text(obj['name']),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.getUserId();
    return Scaffold(
      appBar: MainBar(),
      drawer: MainDrawer(),
      body: StreamBuilder(
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
                  return CollectionTile(i, collection);
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
      ),
    );
  }
}
