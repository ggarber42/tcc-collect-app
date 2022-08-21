import 'package:flutter/material.dart';

import '../form_widgets/form_widget_gps.dart';
import '../form_widgets/form_widget_radio.dart';
import '../form_widgets/form_widget_text.dart';
import '../form_widgets/form_widget_image.dart';
import 'form_widget_interface.dart';

class FormWidgetFactory {

  FormWidget _getSelectedWidget(String selectedValue) {
    FormWidget formWidget;
    switch(selectedValue){
      case 'text':
        formWidget = FormWidgetText();
        break;
      case 'radio':
        formWidget = FormWidgetRadio();
        break;
      case 'gps':
        formWidget = FormWidgetGPS();
        break;
      case 'img':
        formWidget = FormWidgetImage();
        break;
      default: // TO FIX
        formWidget = FormWidgetText();
    }
    return formWidget;
  }



  Future<FormWidget> createFormField(BuildContext context, String selectedValue) async{
    FormWidget selectedFormWidget = _getSelectedWidget(selectedValue);
    await selectedFormWidget.init(context);
    return selectedFormWidget;
  }
}
