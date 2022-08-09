import 'package:flutter/material.dart';

import 'form_widget_interface.dart';

class FormWidgetText implements FormWidget {
  String? _name;

  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  set name(String value) {
    _name = value;
  }

  @override
  Widget getWidgetBody() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '$_name',
      ),
      onSaved: (_) {},
    );
  }

  @override
  Future showCreateDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Nome do campo'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(labelText: 'Digite aqui'),
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _name = _textEditingController.value.text;
                    return Navigator.pop(context, true);
                  }
                  return;
                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }
}
