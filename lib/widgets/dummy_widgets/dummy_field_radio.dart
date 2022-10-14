import 'package:flutter/material.dart';

import '../../interfaces/dummy_interface.dart';
import '../dialog_widgets/dialog_widget_radio.dart';
import 'dummy_radio_item.dart';

class DummyFieldRadio implements Dummy {
  int? _index;
  late String _name;
  late dynamic _options;
  final IconData widgetIcon;
  var dialog = DialogWidgetRadio();

  DummyFieldRadio(this.widgetIcon);

  DummyFieldRadio.fromEditScreen(this.widgetIcon, this._name, this._options);

  get index => _index;
  get name => _name;
  get options => _options;
  @override
  get getType => 'radio';

  Widget _fieldName() {
    var returnedName = name ?? '';
    return ListTile(
      leading: Icon(widgetIcon),
      title: Text(returnedName),
    );
  }

  @override
  Widget getWidgetBody(indexValue, deleteField, context) {
    _index = indexValue;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _fieldName(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _options.length,
              itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 1.5),
                child: DummyRadioItem(_options[index]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    deleteField(_index);
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
    );
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
