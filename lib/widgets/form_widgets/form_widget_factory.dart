import 'package:flutter/material.dart';

import '../dialog_widgets/alert_widget_dialog.dart';
import '../dialog_widgets/widget_dialog_factory.dart';
import '../form_widgets/form_widget_radio.dart';
import '../form_widgets/form_widget_text.dart';

class FormWidgetFactory {

  _showCreateDialog(BuildContext context, String selectedValue){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WidgetDialogFactory(selectedValue).makeWidget();
        });
  }
  

  Future<dynamic> createFormField(BuildContext context, String selectedValue) async {
    var inputValues = await _showCreateDialog(context, selectedValue);
    var newField;
    switch(selectedValue){
      case 'text':
        newField = FormWidgetText(inputValues);
        break;
      case 'radio':
        newField = FormWidgetRadio();
        break;
      default:
        newField = AlertWidgetFormDialog();
        break;
    }
    return newField;
  }
}
