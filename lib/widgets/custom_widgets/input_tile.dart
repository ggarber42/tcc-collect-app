import 'package:flutter/material.dart';

import '../../screens/entries/entry_inputs.dart';

class InputTile extends StatelessWidget {
  final inputFields;
  final Function addValue;

  InputTile(this.inputFields, this.addValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Card(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.file_copy),
              title: Text('Campos'),
            ),
          ],
        )),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EntryInputsScreen(inputFields, addValue),
            )),
      ),
    );
  }
}
