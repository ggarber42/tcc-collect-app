import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  final TextEditingController textController;
  final String name;
  
  NameInput(this.name, this.textController);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 35,
      ),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(labelText: 'Nome do Entrada *'),
        textInputAction: TextInputAction.done,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Esse campo não pode ser nulo';
          }
          return null;
        },
      ),
    );
  }
}
