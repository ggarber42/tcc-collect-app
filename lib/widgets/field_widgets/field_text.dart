import 'package:flutter/material.dart';

import '../../utils/extensions.dart';
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: double.infinity,
                child: Center(
                    child: Text(name.capitalize(),
                        style: TextStyle(fontSize: 17))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.text_fields),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: OutlineInputBorder(),
                    ),
                    controller: controller,
                    textInputAction: TextInputAction.done,
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'Esse campo não pode ser nulo';
                      }
                      return null;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
