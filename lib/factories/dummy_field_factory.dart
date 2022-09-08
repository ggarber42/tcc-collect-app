import 'package:flutter/material.dart';

import '../interfaces/dummy_interface.dart';
import '../widgets/dummy_widgets/dummy_field.dart';
import '../widgets/dummy_widgets/dummy_field_radio.dart';
class DummyFactoryField {

  Dummy _getSelectedWidget(String selectedValue) {
    Dummy dummyField;
    switch(selectedValue){
      case 'date':
        dummyField = DummyField(selectedValue, Icons.date_range);
        break;
      case 'radio':
        dummyField = DummyFieldRadio();
        break;
      case 'gps':
        dummyField = DummyField(selectedValue, Icons.gps_fixed_sharp);
        break;
      case 'img':
        dummyField = DummyField(selectedValue, Icons.image);
        break;
      default:
        dummyField = DummyField(selectedValue, Icons.text_fields);
    }
    return dummyField;
  }



  Future<Dummy> createFormField(BuildContext context, String selectedValue) async{
    Dummy selectedField = _getSelectedWidget(selectedValue);
    await selectedField.init(context);
    return selectedField;
  }
}
