import 'package:flutter/material.dart';


import '../dialog_widgets/radio_widget_dialog.dart';
import '../dialog_widgets/text_widget_dialog.dart';

import '../form_widgets/form_widget_radio.dart';
import '../form_widgets/form_widget_text.dart';

class FormWidgetFactory {

  Map<String, dynamic> _getSelectedWidget(String selectedValue){
    var formWidget;
    var dialog;
    switch(selectedValue){
      case 'text':
        formWidget = FormWidgetText();
        dialog = TextWidgetFormDialog();
        break;
      case 'radio':
        formWidget = FormWidgetRadio();
        dialog = RadioWidgetFormDialog();
        break;
    }
    return {
      'dialog': dialog,
      'formWidget': formWidget
    };
  }

  _getInputValues(BuildContext context, dialog){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dialog;
        });
  }
  

  Future<dynamic> createFormField(BuildContext context, String selectedValue) async {
    var selectedWidgets = _getSelectedWidget(selectedValue);
    var selectedDialog = selectedWidgets['dialog'];
    var selectedFormWidget = selectedWidgets['formWidget'];

    var inputValues = await _getInputValues(context, selectedDialog);
    selectedFormWidget.init(inputValues);
    return selectedFormWidget;
  }
}
