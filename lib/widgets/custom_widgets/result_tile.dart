import 'dart:io';
import 'package:collect_app/widgets/dialog_widgets/dialog_share.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/entry_value.dart';
import '../../screens/entries/entry_result_values.dart';
import '../../utils/arguments.dart';
import '../../utils/constants.dart';

class ResultTile extends StatefulWidget {
  final List<EntryValue> values;

  ResultTile(this.values);

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
      arguments: EntryValuesArguments(widget.values, shareValues),
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
