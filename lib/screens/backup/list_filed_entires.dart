import 'package:flutter/material.dart';

import '../../facades/firestore.dart';
import '../../models/entry_value.dart';
import '../../models/entry_value_collection.dart';
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
      body: StreamBuilder(
        stream: fireFacade.readBackupValues(widget.userId),
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
                  return CollectionTile(
                      i, data[i]['docId'], widget.userId, collection);
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
