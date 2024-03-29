import 'package:flutter/material.dart';

class RadioItemDialog extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              return Navigator.pop(context, _textEditingController.value.text);
            }
            return;
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
