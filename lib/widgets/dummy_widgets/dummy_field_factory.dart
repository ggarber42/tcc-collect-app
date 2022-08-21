import 'package:flutter/material.dart';

import 'dummy_field_gps.dart';
import 'dummy_field_radio.dart';
import 'dummy_field_text.dart';
import 'dummy_field_image.dart';
import 'dummy_field_interface.dart';

class DummyFactoryField {

  DummyField _getSelectedWidget(String selectedValue) {
    DummyField dummyField;
    switch(selectedValue){
      case 'text':
        dummyField = DummyFieldText();
        break;
      case 'radio':
        dummyField = DummyFieldRadio();
        break;
      case 'gps':
        dummyField = DummyFieldGPS();
        break;
      case 'img':
        dummyField = DummyFieldImage();
        break;
      default: // TO FIX
        dummyField = DummyFieldText();
    }
    return dummyField;
  }



  Future<DummyField> createFormField(BuildContext context, String selectedValue) async{
    DummyField selectedField = _getSelectedWidget(selectedValue);
    await selectedField.init(context);
    return selectedField;
  }
}
