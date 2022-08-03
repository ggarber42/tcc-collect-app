import 'package:collect_app/widgets/form_widgets/form_widget_text.dart';
import 'package:flutter/material.dart';

import 'form_widget_interface.dart';
import 'form_widget_radio.dart';

class FormWidgetFactory {
  FormWidget createFormField(BuildContext context, Map<dynamic, dynamic> res){
    if(res['selectedValue'] == 'radio'){
      FormWidgetRadio radio = new FormWidgetRadio();
      radio.showCreateDialog(context);
      return radio;
    } else if(res['selectedValue'] == 'text'){
      FormWidgetText text = new FormWidgetText(res['name']);
      return text;
    }
    return new FormWidgetRadio();
  }
}