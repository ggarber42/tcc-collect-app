import 'package:flutter/material.dart';

import '../../interfaces/dummy_interface.dart';
import '../dialog_widgets/dialog_dummy.dart';

class DummyField implements Dummy {
  int? widgetId;
  late final String name;
  final String type;
  final IconData widgetIcon;

  @override
  get getType => type;
  get getId => widgetId;

  var dialog = DialogDummy();

  DummyField(this.type, this.widgetIcon);

  DummyField.fromEditScreen(
      this.widgetId, this.name, this.type, this.widgetIcon);

  Future<dynamic> showInitDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  @override
  init(BuildContext context) async {
    var inputValue = await showInitDialog(context);
    if (inputValue != null) {
      name = inputValue;
    }
  }

  @override
  Widget getWidgetBody() {
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            icon: Icon(widgetIcon),
            labelText: '$name',
          ),
          onSaved: (_) {},
        ),
      ],
    );
  }
}
