import 'package:flutter/material.dart';

import '../widgets/base_widgets/main_bar.dart';
import '../widgets/base_widgets/main_drawer.dart';
import '../widgets/dialog_widgets/new_field_dialog.dart';
import '../widgets/dummy_widgets/dummy_field_factory.dart';

class AddFormFieldsScreen extends StatefulWidget {
  static const routeName = '/add-fields';

  @override
  _AddFormFieldsScreenState createState() => _AddFormFieldsScreenState();
}

class _AddFormFieldsScreenState extends State<AddFormFieldsScreen> {
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
    var selectedValue = await _showFieldDialog(context);
    if (selectedValue == null) return;
    var newFormField =
        await DummyFactoryField().createFormField(context, selectedValue);
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
            label: Text("Campo de entrada"),
            icon: Icon(Icons.add),
            onPressed: () => _handleFieldDialog(context)),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          color: Theme.of(context).colorScheme.primary,
          textColor: Colors.white,
          elevation :0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Text('Salvar Modelo' , style:  TextStyle(fontSize: 20)),
          onPressed: () {},
        ),
      ),
    );
  }
}
