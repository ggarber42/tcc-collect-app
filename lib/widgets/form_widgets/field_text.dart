import 'package:collect_app/interfaces/field_interface.dart';
import 'package:flutter/material.dart';

class FieldText extends StatelessWidget implements Field {
  final String name;
  final TextEditingController _textEditingController = TextEditingController();

  FieldText(this.name);

  @override
  String getInputValue() {
    return _textEditingController.value.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      decoration: InputDecoration(
          labelText: name,
          icon: Icon(
            Icons.text_fields,
          )),
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Esse campo não pode ser nulo';
        }
        return null;
      },
    );
  }
}
