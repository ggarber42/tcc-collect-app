import 'package:flutter/material.dart';

import '../widgets/base_widgets/main_bar.dart';
import '../widgets/base_widgets/main_drawer.dart';
import '../widgets/dialog_widgets/new_field_dialog.dart';
import '../widgets/form_widgets/form_widget_factory.dart';
import '../widgets/form_widgets/form_widget_interface.dart';

class AddFormFieldsScreen extends StatefulWidget {
  static const routeName = '/add-fields';

  @override
  _AddFormFieldsScreenState createState() => _AddFormFieldsScreenState();
}

class _AddFormFieldsScreenState extends State<AddFormFieldsScreen> {
  var selectedValue;
  var widgetList = [];

  Future _showFieldDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return NewFieldDialog();
        });
  }

  _handleFieldDialog(BuildContext context) async {
    selectedValue = await _showFieldDialog(context);
    if (selectedValue == 'none') return;
    var factory = new FormWidgetFactory();
    FormWidget newFormField =
        await factory.createFormField(context, selectedValue);
    setState(() {
      widgetList.add(newFormField.getWidgetBody());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Novo modelo',
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome do Modelo',
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 400,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: ListView.builder(
                    itemCount: widgetList.length,
                    itemBuilder: (ctx, index) {
                      return widgetList[index];
                    }),
              ),
            )
          ],
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Campo de entrada"),
          icon: Icon(Icons.add),
          onPressed: () => _handleFieldDialog(context)),
    );
  }
}
