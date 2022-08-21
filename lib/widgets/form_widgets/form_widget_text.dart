import 'dart:ffi';

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
  void init(BuildContext context) async{
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
        labelText: '$_name',
      ),
      onSaved: (_) {},
    );
  }

  // @override
  // void init(dynamic value) {
  //   _name = value;
  // }

}
