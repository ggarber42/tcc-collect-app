import 'package:flutter/material.dart';

import '../interfaces/dummy_field_interface.dart';
import '../widgets/dummy_widgets/dymmy_field_date.dart';
import '../widgets/dummy_widgets/dummy_field_image.dart';
import '../widgets/dummy_widgets/dummy_field_gps.dart';
import '../widgets/dummy_widgets/dummy_field_text.dart';
import '../widgets/dummy_widgets/dummy_field_radio.dart';

class DummyFactoryField {

  DummyField _getSelectedWidget(String selectedValue) {
    DummyField dummyField;
    switch(selectedValue){
      case 'date':
        dummyField = DummyFieldDate();
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
      default:
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
