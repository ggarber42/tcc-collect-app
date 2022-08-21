import 'package:flutter/material.dart';

import 'form_widget_interface.dart';
import '../dialog_widgets/dialog_widget_text.dart';

class FormWidgetText implements FormWidget {
  var dialog = DialogWidgetText();
  String? _name;

  Future<dynamic> showInitDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogWidgetText();
        });
  }

  @override 
  init(BuildContext context) async{
    var inputValue = await showInitDialog(context);
    if(inputValue != null){
      _name = inputValue;
    }

  }

  @override
  Widget getWidgetBody() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        icon: Icon(Icons.text_fields),
        labelText: '$_name',
      ),
      onSaved: (_) {},
    );
  }

}
