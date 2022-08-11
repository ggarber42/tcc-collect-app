import 'package:flutter/material.dart';

import '../dialog_widgets/form_dialog_interface.dart';

class RadioWidgetFormDialog extends StatefulWidget{
  @override
  _RadioWidgetFormDialogState createState() => _RadioWidgetFormDialogState();
}

class _RadioWidgetFormDialogState extends State<RadioWidgetFormDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var optionQuantity = 1;
  var _options = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     title: Text('Nome do campo'),
  //     content: Column(children: [
  //       Form(
  //         key: _formKey,
  //         child: TextFormField(
  //           controller: _textEditingController,
  //           decoration: InputDecoration(labelText: 'Digite aqui'),
  //           textInputAction: TextInputAction.done,
  //           validator: (String? value) {
  //             if (value == null || value.isEmpty) {
  //               return 'Please enter some text';
  //             }
  //             return null;
  //           },
  //         ),
  //       ),
  //     ]),
  //     actions: [
  //       FlatButton(
  //         onPressed: () => Navigator.pop(context, false),
  //         child: Text('Cancel'),
  //       ),
  //       FlatButton(
  //         onPressed: () {
  //           print('kkk');
  //         },
  //         child: Text('Adicionar campo'),
  //       ),
  //       FlatButton(
  //         onPressed: () {
  //           if (_formKey.currentState!.validate()) {
  //             return Navigator.pop(context, _textEditingController.value.text);
  //           }
  //           return;
  //         },
  //         child: Text('Finalizar'),
  //       ),
  //     ],
  //   );
  // }

}
