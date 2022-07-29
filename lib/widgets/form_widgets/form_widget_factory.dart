import 'package:flutter/material.dart';

import 'form_widget_interface.dart';
import 'form_widget_radio.dart';

class FormWidgetFactory {
  FormWidget createFormField(BuildContext context, String name){
    if(name == 'radio'){
      FormWidgetRadio radio = new FormWidgetRadio();
      radio.showCreateDialog(context);
      return radio;
    }
    return new FormWidgetRadio();
  }
}