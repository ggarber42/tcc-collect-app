import 'package:flutter/material.dart';

class RadioWidgetFormDialog extends StatefulWidget {
  @override
  _RadioWidgetFormDialogState createState() => _RadioWidgetFormDialogState();
}

class _RadioWidgetFormDialogState extends State<RadioWidgetFormDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var optionQuantity = 1;
  var _options = [
    'kkkk',
    'kkkk',
    'kkkk',
    'kkkk',
    'kkkk',
    'kkkk',
    'kkkk',
    'kkkk'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nome do campo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            child: Form(
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
          ),
          Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _options.length,
                itemBuilder: (ctx, index) => Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(_options[index]),
                    )),
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
                  onPressed: () {
                    print('kkk');
                  },
                  child: Text('Adicionar campo'),
                ),
                FlatButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      return Navigator.pop(
                          context, _textEditingController.value.text);
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
    );
  }
}
