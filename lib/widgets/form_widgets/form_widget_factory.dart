import 'package:flutter/material.dart';

import '../form_widgets/form_widget_radio.dart';
import '../form_widgets/form_widget_text.dart';
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
      default: // TO FIX
        formWidget = FormWidgetText();
    }
    return formWidget;
  }



  FormWidget createFormField(BuildContext context, String selectedValue) {
    FormWidget selectedFormWidget = _getSelectedWidget(selectedValue);
    selectedFormWidget.init(context);
    return selectedFormWidget;
  }
}
