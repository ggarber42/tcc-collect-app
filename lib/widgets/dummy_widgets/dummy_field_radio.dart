import 'package:flutter/material.dart';

import 'dummy_field_interface.dart';
import 'dummy_radio_item.dart';
import '../dialog_widgets/dialog_widget_radio.dart';

class DummyFieldRadio implements DummyField {
  var dialog = DialogWidgetRadio();
  late String _name;
  late dynamic _options;
  String _type = 'radio';

  String get name => _name;
  String get type => _type;
  dynamic get options => _options;

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

  @override
  String getQuery() {
    // TODO: implement getQuery
    throw UnimplementedError();
  }
}
