import 'package:flutter/material.dart';

import '../widgets/main_bar.dart';
import '../widgets/main_drawer.dart';

class CreateModelsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: MainBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Criando Modelos de Formulários')],
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}