import 'package:flutter/material.dart';

import '../custom_widgets/field_input.dart';
import '../../interfaces/field_interface.dart';
import '../../widgets/custom_widgets/field_card.dart';
import '../../widgets/base_widgets/field_title.dart';

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
    return FieldCard(children: [
      FieldTitle(name),
      FieldInput(
        controller: controller,
        iconData: Icons.text_fields,
      )
    ]);
  }
}
