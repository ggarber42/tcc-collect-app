import 'package:flutter/material.dart';

import 'form_widget_interface.dart';

class FormWidgetText implements FormWidget {
  final String name;

  FormWidgetText(this.name);

  @override
  Widget getWidgetBody() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: '$name',
      ),
      onSaved: (_) {},
    );
  }

}
