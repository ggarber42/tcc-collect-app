import 'package:flutter/material.dart';

class AlertWidgetFormDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Run chicken run'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Algo deu errado!!!'),
              Text('Me contate no github'),
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