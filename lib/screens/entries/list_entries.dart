import 'package:collect_app/models/entry.dart';
import 'package:collect_app/widgets/custom_widgets/entry_tile.dart';
import 'package:flutter/material.dart';

import '../../dao/entry_dao.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import 'entry_name.dart';

class ListEntriesScreen extends StatelessWidget {
  static const routeName = '/list_entries';
  final int modelId;
  final String modelName;

  ListEntriesScreen(this.modelId, this.modelName);

 
  _fetchEntries() async {
    EntryDAO entryDao = EntryDAO();
    var entries = [...await entryDao.readAll(modelId)];
    return entries;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(windowTitle: modelName),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: FutureBuilder(
          future: _fetchEntries(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var entries = snapshot.data as List<Entry>;
              return ListView.builder(
                itemCount: entries.length,
                itemBuilder: (ctx, i) => EntryTile(entries[i]),
              );
            }
            return Center(child: Text('Nao existem entradas'));
          },
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Entrada"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EntryNameScreen(modelId),
            ),
          );
        },
      ),
    );
  }
}
