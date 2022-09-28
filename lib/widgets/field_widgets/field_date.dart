import 'package:collect_app/interfaces/field_interface.dart';
import 'package:flutter/material.dart';

class FieldDate extends StatelessWidget implements Field {
  final String name;
  final TextEditingController textEditingController;

  @override
  Map<String, String> getInputValue() {
    return {'name': name, 'value': textEditingController.value.text};
  }

  FieldDate(this.name, this.textEditingController);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        icon: Icon(Icons.date_range),
        labelText: name,
      ),
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Esse campo não pode ser nulo';
        }
        return null;
      },
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2019),
          lastDate: DateTime.now(),
        ).then((pickedDate) {
          if (pickedDate == null) {
            return;
          }
          textEditingController.text = pickedDate.toIso8601String();
        });
      },
    );
  }
}
