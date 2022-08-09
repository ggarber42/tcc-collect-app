import 'package:collect_app/widgets/form_widgets/form_widget_text.dart';
import 'package:flutter/material.dart';

import 'form_widget_interface.dart';
import 'form_widget_radio.dart';

class FormWidgetFactory {

  Future<FormWidget> createFormField(BuildContext context, String selectedValue) async{
    if(selectedValue == 'radio'){
      FormWidgetRadio radio = new FormWidgetRadio();
      radio.showCreateDialog(context);
      return radio;
    } else if(selectedValue == 'text'){
      var text = new FormWidgetText();
      var res = await text.showCreateDialog(context);
      text.name = res;
      return text;
    }
    return new FormWidgetRadio();
  }
}