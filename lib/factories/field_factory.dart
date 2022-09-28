import 'package:flutter/cupertino.dart'; //rever

import 'field_date_factory.dart';
import 'field_img_factory.dart';
import 'field_gps_factory.dart';
import 'field_text_factory.dart';
import 'field_radio_factory.dart';

class FieldFactory {
  dynamic _selectFactory(String type) {
    var selectedFactory;
    switch (type) {
      case 'date':
        selectedFactory = FieldDateFactory();
        break;
      case 'radio':
        selectedFactory = FieldRadioFactory();
        break;
      case 'gps':
        selectedFactory = FieldGPSFactory();
        break;
      case 'img':
        selectedFactory = FieldImgFactory();
        break;
      default:
        selectedFactory = FieldTextFactory();
        break;
    }
    return selectedFactory;
  }

  Future<Widget> makeFormWidget(
    int widgetId,
    String type,
    TextEditingController controller,
  ) async {
    var selectedFactory = _selectFactory(type);
    var field = await selectedFactory.makeWidget(widgetId, controller);
    return field;
  }
}
