import 'package:flutter/material.dart';

import '../dialog_widgets/widget_dialog_factory.dart';

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
    var newField = await _showCreateDialog(context, selectedValue);
    return newField;
  }
}
