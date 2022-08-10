import 'package:flutter/material.dart';

import '../dialog_widgets/form_dialog_interface.dart';
import '../dialog_widgets/text_widget_dialog.dart';
import '../form_widgets/form_widget_text.dart';
import 'form_widget_interface.dart';
import 'form_widget_radio.dart';

class FormWidgetFactory {

  Future<dynamic> createFormField(BuildContext context, String selectedValue) async {
    FormWidget? newField;
    switch (selectedValue) {
      case 'text':
        var name = await TextWidgetFormDialog().showCreateDialog(context);
        newField = new FormWidgetText(name);
        break;
      default:
        break;
    }
    return newField;
  }
}
