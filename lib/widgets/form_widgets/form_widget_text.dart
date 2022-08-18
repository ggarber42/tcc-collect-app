import 'package:flutter/material.dart';

import 'form_widget_interface.dart';

class FormWidgetText implements FormWidget {
  String? _name;

  FormWidgetText();

  @override
  Widget getWidgetBody() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: '$_name',
      ),
      onSaved: (_) {},
    );
  }

  @override
  void init(dynamic value) {
    _name = value;
  }

}
