import 'package:flutter/material.dart';

class AlertWidgetFormDialog extends StatelessWidget {
  final String _warningText;

  AlertWidgetFormDialog(this._warningText);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(_warningText),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
