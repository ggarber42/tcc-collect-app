import 'package:flutter/material.dart';

import 'form_widget_interface.dart';
import '../dialog_widgets/dialog_widget_text.dart';

class FormWidgetImage implements FormWidget {
  var dialog = DialogWidgetText();
  late String _name;
  var _widgetIcon = Icon(Icons.image);


  Future<dynamic> showInitDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dialog;
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
        icon: _widgetIcon,
        labelText: '$_name',
      ),
      onSaved: (_) {},
    );
  }

 
}
