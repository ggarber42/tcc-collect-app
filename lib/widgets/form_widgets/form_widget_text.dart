import 'package:flutter/material.dart';

import 'form_widget_interface.dart';

class FormWidgetText implements FormWidget {
  String name;

  FormWidgetText(this.name);

  @override
  Widget getWidgetBody() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: '$name',
        ),
        onSaved: (String? value) {
          print(value);
        });
  }

}
