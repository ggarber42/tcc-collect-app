import 'package:flutter/cupertino.dart';

import '../interfaces/field_interface.dart';
import '../widgets/form_widgets/field_text.dart';

class FormFactory {
  Field _selectField(String type) {
    Field field;
    switch (type) {
      default:
        field = FieldText();
        break;
    }
    return field;
  }

  Future<Widget> makeField(int widgetId, String type) async {
    Field selectedField = _selectField(type);
    await selectedField.init(widgetId);
    return selectedField.getWidgetBody();
  }
}
