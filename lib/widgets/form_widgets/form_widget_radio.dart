import 'package:flutter/material.dart';

import 'form_widget_interface.dart';

class FormWidgetRadio extends FormWidget {
  String? name;

  FormWidgetRadio();

  FormWidgetRadio.dialog(this.name);

  @override
  Widget getWidgetBody() {
    return ListTile(
      title: Text('Misha'),
      leading: Radio(
          value: 1,
          groupValue: 1,
          onChanged: (value) {
            print(value);
          }),
    );
  }

  @override
  Future<dynamic> showCreateDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Wanna Exit?'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context, true), // passing true
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
