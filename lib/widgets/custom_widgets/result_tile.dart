import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect_app/widgets/dialog_widgets/dialog_share.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/entry_value.dart';
import '../../models/entry_value_collection.dart';
import '../../screens/entries/entry_result_values.dart';
import '../../utils/arguments.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';

class ResultTile extends StatefulWidget {
  final String entryName;
  final List<EntryValue> values;

  ResultTile(this.entryName, this.values);

  @override
  State<ResultTile> createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
  var _tapPosition;

  _getValuesAsText() {
    var valuesAsText = '';
    widget.values.forEach((value) {
      valuesAsText += '${value.getName} ${value.getValue}\n';
    });
    return valuesAsText;
  }

  _generateCSV() {
    List<List<dynamic>> rows = [];

    for (var value in widget.values) {
      List<dynamic> row = [];
      row.add(value.getName);
      rows.add(row);
    }
    for (var value in widget.values) {
      List<dynamic> row = [];
      row.add(value.getValue);
      rows.add(row);
    }
    return ListToCsvConverter().convert(rows);
  }

  backupEntryValues() async {
    final docId = Helper.getUuid();
    final collectDoc =
        FirebaseFirestore.instance
        .collection(VALUE_COLLECTION)
        .doc(docId);
    final valuesCollection = EntryValueCollection(
      entryName: widget.entryName,
      values: widget.values,
    );
    collectDoc.set(valuesCollection.toJson());
    Helper.showSnack(context, 'Backup realizado');
  }

  showShareDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogShare();
        });
  }

  shareValues() async {
    final selectedValue = await showShareDialog();
    print(selectedValue);
    if (selectedValue == null) return;
    switch (selectedValue) {
      case 'csv':
        final csv = await _generateCSV();
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/values.txt').create();
        await file.writeAsString(csv);
        Share.shareFiles([file.path]);
        break;
      default:
        final valuesAsText = _getValuesAsText();
        Share.share(valuesAsText);
        break;
    }
  }

  _getTapPosition(details) {
    setState((() => _tapPosition = details.globalPosition));
  }

  _goToResultsScreen() {
    Navigator.pushNamed(
      context,
      EntryValuesResultScreen.routeName,
      arguments: EntryValuesArguments(widget.values, shareValues, backupEntryValues),
    );
  }

  _showContextMenu() async {
    final dx = _tapPosition.dx;
    final dy = _tapPosition.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, 0, 0),
      items: ResultTileValueOptions,
      elevation: 8.0,
    );
    return result;
  }

  void _openMenu() async {
    final selectedOption = await _showContextMenu();
    switch (selectedOption) {
      case 'open':
        _goToResultsScreen();
        break;
      case 'share':
        shareValues();
        break;
      case 'backup':
        await backupEntryValues();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _getTapPosition(details),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.check_box),
          title: Text('Resultados campos'),
          trailing: Icon(Icons.more_vert),
          onTap: _goToResultsScreen,
          onLongPress: _openMenu,
        ),
      ),
    );
  }
}
