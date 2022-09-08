import 'package:flutter/material.dart';

import '../../interfaces/dummy_interface.dart';
import '../dialog_widgets/dialog_widget_radio.dart';
import 'dummy_radio_item.dart';

class DummyFieldRadio implements Dummy {
  late String _name;
  late dynamic _options;

  var dialog = DialogWidgetRadio();

  get name => _name;
  get options => _options;
  get typeValue => 'radio';

  @override
  Widget getWidgetBody() {
    return Column(children: [
      Text(_name),
      ListView.builder(
        shrinkWrap: true,
        itemCount: _options.length,
        itemBuilder: (ctx, index) => Container(
          margin: EdgeInsets.symmetric(vertical: 1.5),
          child: DummyRadioItem(_options[index]),
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
