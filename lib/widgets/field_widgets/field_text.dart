// import 'package:collect_app/interfaces/field_interface.dart';
import 'package:collect_app/interfaces/field_interface.dart';
import 'package:flutter/material.dart';

class FieldText extends StatelessWidget implements Field {
  final String name;
  final TextEditingController controller;

  FieldText(this.name, this.controller);

  @override
  Map<String, String> getInputValue() {
    return {
      'name': name,
      'value': controller.value.text
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
      }
    );
  }
}
