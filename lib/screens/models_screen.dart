import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ModelsScreen extends StatefulWidget {
  final String appTitle;

  ModelsScreen(this.appTitle);

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Olá flutter')],
        ),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Modelo"),
        icon: Icon(Icons.add),
        onPressed: () {
          print('kkkk');
        },
      ),
    );
  }
}
