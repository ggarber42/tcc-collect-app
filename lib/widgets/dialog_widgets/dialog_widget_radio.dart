import 'package:collect_app/widgets/dialog_widgets/alert_widget_dialog.dart';
import 'package:flutter/material.dart';

import '../dummy_widgets/dummy_radio_item.dart';
import 'radio_item_dialog.dart';

class DialogWidgetRadio extends StatefulWidget {
  @override
  _DialogWidgetRadioState createState() => _DialogWidgetRadioState();
}

class _DialogWidgetRadioState extends State<DialogWidgetRadio> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _selectedValue;
  var _options = [];

  Future _showAddFieldDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return RadioItemDialog();
        });
  }

  _showWarningDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertWidgetFormDialog('Adicione pelo menos um campo!');
        });
  }

  _handleDialog() async {
    _selectedValue = await _showAddFieldDialog(context);
    if (_selectedValue == null) return;
    setState(() {
      _options.add(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nome do campo'),
      content: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 75,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(labelText: 'Digite aqui'),
                  textInputAction: TextInputAction.done,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Esse campo não pode ser';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.grey),
                ),
              ),
              width: double.maxFinite,
              height: 200,
              child: Scrollbar(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _options.length,
                    itemBuilder: (ctx, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 1.5),
                        child: DummyRadioItem(_options[index]))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () => _handleDialog(),
                    child: Text('Adicionar campo'),
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_options.length == 0) {
                        _showWarningDialog(context);
                      }
                      if (_formKey.currentState!.validate() &&
                          _options.length > 0) {
                        var selectedValues = {
                          'name': _textEditingController.value.text,
                          'options': _options
                        };
                        return Navigator.pop(
                            context, selectedValues);
                      }
                      return;
                    },
                    child: Text('Finalizar'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
