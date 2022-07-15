import 'package:collect_app/screens/create_models_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class ListModelsScreen extends StatelessWidget {
  static const routeName = '/list_models';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collect-app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Olá flutter')],
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Modelo"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) =>  CreateModelsScreen()),
          );
        },
      ),
    );
  }
}
