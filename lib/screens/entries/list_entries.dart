import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'entry_name.dart';
import '../../dao/entry_dao.dart';
import '../../dao/entry_image_dao.dart';
import '../../dao/entry_value_dao.dart';
import '../../facades/share.dart'; 
import '../../models/entry.dart';
import '../../widgets/custom_widgets/main_bottom.dart';
import '../../widgets/custom_widgets/entry_tile.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/dialog_widgets/dialog_shareAll.dart';
import '../../utils/helper.dart';

class ListEntriesScreen extends StatefulWidget {
  static const routeName = '/list_entries';
  final int modelId;
  final String modelName;

  ListEntriesScreen(this.modelId, this.modelName);

  @override
  State<ListEntriesScreen> createState() => _ListEntriesScreenState();
}

class _ListEntriesScreenState extends State<ListEntriesScreen> {
  final shareFacade = ShareFacade();
  final entryDao = EntryDAO();
  final imageDao = EntryImageDAO();
  final valueDao = EntryValueDAO();

  deleteEntry(int entryId) async {
    await entryDao.delete(entryId);
    setState(() {
      Helper.showSnack(context, 'Entrada deletada');
    });
  }

  _fetchEntries() async {
    final entries = [...await entryDao.readAll(widget.modelId)];
    return entries;
  }

  showShareDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogShareAll();
        });
  }

  shareAllEntryValues() async {
    final selectedValue = await showShareDialog();
    if (selectedValue == null) return;
    switch (selectedValue) {
      case 'fields':
        shareFacade.shareAllValueFieldsFromModel(widget.modelId);
        break;
      case 'imgs':
        shareFacade.shareAllImagesFromModel(widget.modelId);
        break;
      default:
        break;
    }
  }

  updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Entradas: ${widget.modelName}',
        hasBackButton: true,
        hasShareAction: true,
        shareFunction: shareAllEntryValues,
        clickHandler: () => Navigator.of(context).pop(),
      ),
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
                itemBuilder: (ctx, i) =>
                    EntryTile(entries[i], deleteEntry, updateState),
              );
            }
            return Center(child: Text('Nao existem entradas'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Entrada"),
        icon: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EntryNameScreen(widget.modelId),
            ),
          );
          setState(() {});
        },
      ),
      bottomNavigationBar: MainBottom(),
    );
  }
}
