import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect_app/models/entry_value.dart';
import 'package:collect_app/widgets/base_widgets/main_drawer.dart';
import 'package:collect_app/widgets/custom_widgets/collection_tile.dart';
import 'package:flutter/material.dart';

import '../../models/entry_value_collection.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../../widgets/custom_widgets/field_card.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/dialog_widgets/dialog_dummy.dart';

class ListBackupValuesScreen extends StatefulWidget {
  static const routeName = '/list-backup';
  const ListBackupValuesScreen({Key? key}) : super(key: key);

  @override
  State<ListBackupValuesScreen> createState() => _ListBackupValuesScreenState();
}

class _ListBackupValuesScreenState extends State<ListBackupValuesScreen> {
  Stream<List<dynamic>> readValueCollections() => FirebaseFirestore.instance
      .collection(VALUE_COLLECTION)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => {'docId': doc.id, 'data': doc.data()})
          .toList());

  _createCat(String catName) async {
    final docId = Helper.getUuid();
    final docUser = FirebaseFirestore.instance.collection('user').doc(docId);
    final json = {'name': catName};
    await docUser.set(json);
    Helper.showSnack(context, 'Nome adicionado!');
  }

  _showModal() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogDummy();
        });
  }

  _handleClick() async {
    final catName = await _showModal();
    _createCat(catName);
  }

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
    return Scaffold(
      appBar: MainBar(),
      drawer: MainDrawer(),
      body: StreamBuilder(
        stream: readValueCollections(),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleClick,
        label: Icon(Icons.add),
      ),
    );
  }
}
