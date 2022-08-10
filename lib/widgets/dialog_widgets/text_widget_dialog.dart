import 'package:flutter/material.dart';

import 'form_dialog_interface.dart';

class TextWidgetFormDialog implements FormWidgetDialog {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Future<dynamic> showCreateDialog(BuildContext context) {
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
                    return Navigator.pop(
                        context, _textEditingController.value.text);
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
