import 'package:flutter/material.dart';

import 'form_widget_interface.dart';

class FormWidgetRadio extends FormWidget{
  String? name;

  FormWidgetRadio();

  FormWidgetRadio.dialog(this.name);


  @override
  Widget getWidgetBody() {
    return ListTile(
          title: Text('Misha'),
          leading: Radio(
            value: 1,
            groupValue: 1,
            onChanged: (value){
              print(value);
            }
          ),
        );
  }

  @override
  void showCreateDialog() {
    // TODO: implement showCreateDialog
  }
 

}