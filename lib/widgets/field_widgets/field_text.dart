import 'package:flutter/material.dart';

import '../../interfaces/field_interface.dart';

class FieldText extends StatelessWidget implements Field {
  final int widgetId;
  final String name;
  final TextEditingController controller;

  FieldText(this.widgetId, this.name, this.controller);

  @override
  Map<String, dynamic> getInputValue() {
    return {
      'widgetId': widgetId,
      'name': name,
      'type': 'input',
      'value': controller.value.text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: name,
            icon: Icon(
              Icons.text_fields,
            )),
        textInputAction: TextInputAction.done,
        validator: (String? text) {
          if (text == null || text.isEmpty) {
            return 'Esse campo não pode ser nulo';
          }
          return null;
        });
  }
}
