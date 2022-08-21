import 'package:flutter/material.dart';

import 'form_widget_interface.dart';
import '../dialog_widgets/dialog_widget_radio.dart';
class FormWidgetRadio implements FormWidget {
  var dialog = DialogWidgetRadio();
  dynamic _options;

  @override
  Widget getWidgetBody() {
    return ListTile(
      title: Text('Misha'),
      leading: Radio(
          value: 1,
          groupValue: 1,
          onChanged: (value) {
            print(value);
          }),
    );
  }

   Future<dynamic> showInitDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogWidgetRadio();
        });
  }

  @override 
  void init(BuildContext context) async{
    var inputValues = await showInitDialog(context);
    if(inputValues != null){
      _options = inputValues;
      print(inputValues);
    }

  }

}
