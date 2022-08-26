import 'package:flutter/material.dart';

import 'dummy_field_interface.dart';
import '../dialog_widgets/dialog_widget_text.dart';

class DummyFieldImage implements DummyField {
  var dialog = DialogWidgetText();
  var _widgetIcon = Icon(Icons.image);
  late String _name;
  String _type = 'image';
  
  String get name => _name;
  String get type => _type;


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
  
  @override
  String getQuery() {
    // TODO: implement getQuery
    throw UnimplementedError();
  }

 
}
