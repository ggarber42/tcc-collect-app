import 'package:collect_app/widgets/custom_widgets/main_bottom.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

import '../../facades/share.dart';
import '../../models/entry.dart';
import '../../models/entry_value.dart';
import '../../widgets/dialog_widgets/dialog_share.dart';

class ListFieldValuesScreen extends StatelessWidget {
  final Entry entry;
  final VoidCallback deleteFunction;
  final shareFacade = ShareFacade();

  ListFieldValuesScreen(this.entry, this.deleteFunction);

  _getValuesAsText() {
    var valuesAsText = '';
    entry.getValues.forEach((value) {
      valuesAsText += '${value.getName} ${value.getValue}\n';
    });
    return valuesAsText;
  }

  _generateCSV() {
    List<List<dynamic>> rows = [];

    for (var value in entry.getValues) {
      List<dynamic> row = [];
      row.add(value.getName);
      rows.add(row);
    }
    for (var value in entry.getValues) {
      List<dynamic> row = [];
      row.add(value.getValue);
      rows.add(row);
    }
    return ListToCsvConverter().convert(rows);
  }

  Widget _fieldTile(EntryValue value) {
    return Column(
      children: [
        ListTile(
          title: Text(value.getName),
          subtitle: Text(value.getValue),
        ),
        Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final values = entry.getValues;
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.getName),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              final selectedValue = await showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return DialogShare();
                  });
              if (selectedValue == null) return;
              switch (selectedValue) {
                case 'csv':
                  final csv = await _generateCSV();
                  shareFacade.shareCSV(csv);
                  break;
                default:
                  final valuesAsText = _getValuesAsText();
                  Share.share(valuesAsText);
                  break;
              }
            },
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: deleteFunction,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        height: size.height * 0.8,
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: values.length,
            itemBuilder: ((context, index) => _fieldTile(values[index])),
          ),
        ),
      ),
      bottomNavigationBar: MainBottom(currentIndex: 2),
    );
  }
}
