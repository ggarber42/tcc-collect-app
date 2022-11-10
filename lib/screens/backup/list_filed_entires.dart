import 'package:collect_app/widgets/custom_widgets/main_bottom.dart';
import 'package:flutter/material.dart';

import '../../facades/firestore.dart';
import '../../models/entry_value.dart';
import '../../models/entry_value_collection.dart';
import '../../widgets/base_widgets/error_warning.dart';
import '../../widgets/custom_widgets/collection_tile.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class ListFieldEntriesScreen extends StatefulWidget {
  final String userId;
  static const routeName = '/list_field_entries_online';

  ListFieldEntriesScreen(this.userId);

  @override
  State<ListFieldEntriesScreen> createState() => _ListFieldEntriesScreenState();
}

class _ListFieldEntriesScreenState extends State<ListFieldEntriesScreen> {
  final fireFacade = FirestoreFacade();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      bottomNavigationBar: MainBottom(currentIndex: 2,),
      body: StreamBuilder(
        stream: fireFacade.readBackupValues(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List;
             if (data.isEmpty) {
                return Center(
                  child: Text(
                    'Não há valores cadastrados!',
                    style: TextStyle(fontSize: 22),
                  ),
                );
              }
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
                  return CollectionTile(
                      i, data[i]['docId'], widget.userId, collection);
                });
          } else if (snapshot.hasError) {
            return ErrorWarning();
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
