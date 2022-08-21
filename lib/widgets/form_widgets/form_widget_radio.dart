import 'package:flutter/material.dart';

import 'form_widget_interface.dart';
import '../base_widgets/radio_dummy_item.dart';
import '../dialog_widgets/dialog_widget_radio.dart';

class FormWidgetRadio implements FormWidget {
  var dialog = DialogWidgetRadio();
  var _name;
  dynamic _options;

  @override
  Widget getWidgetBody() {
    return Column(children: [
      Text(_name as String),
      ListView.builder(
        shrinkWrap: true,
        itemCount: _options.length,
        itemBuilder: (ctx, index) => Container(
          margin: EdgeInsets.symmetric(vertical: 1.5),
          child: RadioDummyItem(_options[index]),
        ),
      )
    ]);
  }

  Future<dynamic> showInitDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogWidgetRadio();
        });
  }

  @override
  void init(BuildContext context) async {
    var inputValues = await showInitDialog(context);
    if (inputValues != null) {
      var selectedValues = inputValues;
      _name = selectedValues['name'];
      _options = selectedValues['options'];
    }
  }
}
