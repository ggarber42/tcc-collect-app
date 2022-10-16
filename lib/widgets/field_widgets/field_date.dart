import 'package:collect_app/widgets/base_widgets/field_title.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/field_card.dart';
import '../../interfaces/field_interface.dart';
import '../custom_widgets/field_input.dart';

class FieldDate extends StatelessWidget implements Field {
  final int widgetId;
  final String name;
  final TextEditingController controller;

  FieldDate(this.widgetId, this.name, this.controller);

  @override
  Map<String, dynamic> getInputValue() {
    return {
      'widgetId': widgetId,
      'name': name,
      'type': 'input',
      'value': controller.value.text
    };
  }

  @override
  Widget build(BuildContext context) {
    return FieldCard(
      children: [
        FieldTitle(name),
        FieldInput(
          controller: controller,
          iconData: Icons.date_range,
          readOnly: true,
        ),
        ElevatedButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ).then((pickedDate) {
                if (pickedDate == null) {
                  return;
                }
                controller.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
              });
            },
            child: Text('SELECIONE'))
      ],
    );
  }
}
