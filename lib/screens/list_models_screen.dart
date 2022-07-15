import 'package:flutter/material.dart';

import '../screens/create_models_screen.dart';
import '../widgets/main_bar.dart';
import '../widgets/main_drawer.dart';

class ListModelsScreen extends StatelessWidget {
  static const routeName = '/list_models';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
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
