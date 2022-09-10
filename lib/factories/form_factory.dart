import 'package:flutter/cupertino.dart';

import 'field_text_factory.dart';
import 'field_date_factory.dart';

class FormFactory {

  dynamic _selectFactory(String type) {
    var selectedFactory;
    switch (type) {
      case 'date':
        selectedFactory = FieldDateFactory();
        break;
      default:
        selectedFactory = FieldTextFactory();
        break;
    }
    return selectedFactory;
  }

  Future<Widget> makeFormWidget(int widgetId, String type) async {
    // Field selectedField = _selectField(type);
    // await selectedField.init(widgetId);
    // return selectedField;
    var selectedFactory = _selectFactory(type);
    var field = await selectedFactory.makeWidget(widgetId);
    return field;
  }
}
