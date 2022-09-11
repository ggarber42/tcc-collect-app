import 'package:collect_app/models/entry.dart';
import 'package:flutter/material.dart';

import '../../dao/entry_dao.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import 'moldel_detail_screen.dart';

class ListEntriesScreen extends StatefulWidget {
  static const routeName = '/list_entries';
  final int modelId;
  final String modelName;

  ListEntriesScreen(this.modelId, this.modelName);

  @override
  State<ListEntriesScreen> createState() => _ListEntriesScreenState();
}

class _ListEntriesScreenState extends State<ListEntriesScreen> {
  _fetchEntries() async {
    EntryDAO entrieDao = EntryDAO();
    var entrys = [...await entrieDao.readAll(widget.modelId)];
    return entrys;
  }

  @override
  void initState() {
    super.initState();
    _fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(windowTitle: widget.modelName),
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
                itemBuilder: (ctx, index) => Text('oi'),
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
                builder: (_) => ModelDetailScreen(widget.modelId)),
          );
        },
      ),
    );
  }
}
