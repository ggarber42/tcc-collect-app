import 'package:flutter/material.dart';

class FieldInput extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final bool readOnly;

  FieldInput({
    required this.controller,
    required this.iconData,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(),
          prefixIcon: Icon(iconData),
        ),
        textInputAction: TextInputAction.done,
        validator: (String? text) {
          if (text == null || text.isEmpty) {
            return 'Esse campo não pode ser nulo';
          }
          return null;
        },
      ),
    );
  }
}
