import 'package:flutter/material.dart';

import '../interfaces/dummy_interface.dart';
import '../widgets/dummy_widgets/dummy_field.dart';
import '../widgets/dummy_widgets/dummy_field_radio.dart';
class DummyFactoryField {

  Dummy _getSelectedWidget(String selectedType) {
    Dummy dummyField;
    switch(selectedType){
      case 'date':
        dummyField = DummyField(selectedType, Icons.date_range);
        break;
      case 'radio':
        dummyField = DummyFieldRadio();
        break;
      case 'gps':
        dummyField = DummyField(selectedType, Icons.gps_fixed_sharp);
        break;
      case 'img':
        dummyField = DummyField(selectedType, Icons.image);
        break;
      default:
        dummyField = DummyField(selectedType, Icons.text_fields);
    }
    return dummyField;
  }



  Future<Dummy> createFormField(BuildContext context, String selectedType) async{
    Dummy selectedField = _getSelectedWidget(selectedType);
    await selectedField.init(context);
    return selectedField;
  }
}
