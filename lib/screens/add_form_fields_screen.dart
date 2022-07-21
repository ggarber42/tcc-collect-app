import '../widgets/compose_widgets/new_field_dialog.dart';
import 'package:flutter/material.dart';

import '../widgets/base_widgets/main_bar.dart';
import '../widgets/base_widgets/main_drawer.dart';

class AddFormFieldsScreen extends StatefulWidget {
  static const routeName = '/add-fields';

  @override
  _AddFormFieldsScreenState createState() => _AddFormFieldsScreenState();
}

class _AddFormFieldsScreenState extends State<AddFormFieldsScreen> {
  var widgetList = [];

  Future<void> _showFieldDialog(BuildContext context){
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return NewFieldDialog();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(windowTitle: 'Novo modelo',),
      body: Column(
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
              child: ListView.builder(
                  itemCount: widgetList.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text('kkk')
                    );
                  }),
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Campo de entrada"),
        icon: Icon(Icons.add),
        onPressed: () => _showFieldDialog(context)
      ),
    );
  }
}
