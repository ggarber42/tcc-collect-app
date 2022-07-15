import 'package:flutter/material.dart';

import '../widgets/main_bar.dart';
import '../widgets/main_drawer.dart';

class AddModelsWidgetScreen extends StatefulWidget {
  static const routeName = '/add-fields';

  @override
  _AddModelsWidgetScreenState createState() => _AddModelsWidgetScreenState();
}

class _AddModelsWidgetScreenState extends State<AddModelsWidgetScreen> {
  var widgetList = [1,2,3,4,5,6,7,9,8,8,4,5,6,43,6];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
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
        onPressed: () {},
      ),
    );
  }
}
