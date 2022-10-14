import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../interfaces/dummy_interface.dart';
import '../../utils/helper.dart';
import '../dialog_widgets/dialog_dummy.dart';

class DummyField implements Dummy {
  int? index;
  int? widgetId;
  String? name;
  final String type;
  final IconData widgetIcon;

  @override
  get getType => type;
  get getId => widgetId;

  get getIndex => index;

  var dialog = DialogDummy();

  DummyField(this.type, this.widgetIcon);

  // DummyField.fromEditScreen(
  //     this.widgetId, this.name, this.type, this.widgetIcon);

  DummyField.fromEditScreen(
      {required this.widgetId,
      required this.name,
      required this.type,
      required this.widgetIcon});

  Future<dynamic> showInitDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  void setIndex(value) {
    index = value;
  }

  @override
  init(BuildContext context) async {
    var inputValue = await showInitDialog(context);
    if (inputValue != null) {
      name = inputValue;
    }
  }

  Widget _fieldName() {
    var returnedName = name ?? '';
    return ListTile(
      title: Text(returnedName),
    );
  }

  @override
  Widget getWidgetBody(indexValue, deleteField, context) {
    index = indexValue;
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _fieldName(),
              ListTile(
                leading: Icon(widgetIcon),
                title: Text(
                  'Tipo: ${Helper.getTypeNameForUser(type)}',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('RENOMEAR'),
                    onPressed: () => init(context),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      deleteField(index);
                    },
                    icon: Icon(Icons.delete_forever),
                    label: Text(''),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
