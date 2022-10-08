import 'package:flutter/material.dart';

import '../../factories/field_factory.dart';
import '../../models/entry_value.dart';
import '../../utils/helper.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/base_widgets/main_bar.dart';

class EntryInputsScreen extends StatefulWidget {
  final List<dynamic> inputFields;
  final Function addValue;

  EntryInputsScreen(this.inputFields, this.addValue);

  @override
  State<EntryInputsScreen> createState() => _EntryInputsScreenState();
}

class _EntryInputsScreenState extends State<EntryInputsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FieldFactory fieldFactory = FieldFactory();
  var _inputFields;
  var _controllers = [];

  dynamic _customInputs() async {
    var newFields = [];
    for (var i = 0; i < widget.inputFields.length; i++) {
      _controllers.add(TextEditingController());
      var newField = await fieldFactory.makeFormWidget(
        widget.inputFields[i]['widgetId'] as int,
        widget.inputFields[i]['type'] as String,
        _controllers[i],
      );
      newFields.add(newField);
    }
    return newFields;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 35,
                    ),
                    child: FutureBuilder(
                      future: _customInputs(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _inputFields = snapshot.data;
                          return ListView.builder(
                            itemCount: _inputFields.length,
                            itemBuilder: (ctx, index) => _inputFields[index],
                          );
                        }
                        return Center(
                          child: Text('Não há inputs cadastrados.'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: BottomButton('Avançar', () {
                    var newValues = [];
                    if (_formKey.currentState!.validate()) {
                      for (var i = 0; i < _inputFields.length; i++) {
                        newValues.add(
                          _inputFields[i].getInputValue()
                        );
                      }
                      widget.addValue(newValues);
                      Helper.showSnack(context, 'Valor adicionado');
                      Navigator.pop(context);
                    }
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
