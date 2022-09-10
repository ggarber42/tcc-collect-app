import 'package:flutter/material.dart';

class FieldDate extends StatelessWidget {
  final String name;
  final TextEditingController _textEditingController = TextEditingController();

  FieldDate(this.name);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
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
          _textEditingController.text = pickedDate.toIso8601String();
        });
      },
    );
  }
}
