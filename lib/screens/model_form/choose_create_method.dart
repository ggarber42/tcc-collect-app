import 'create_form_model.dart';
import '../../widgets/base_widgets/form_input.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';

class CreateModelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MainBar(windowTitle: 'Modelos'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: FormInput(placeHolder: 'Pesquise por modelos prontos'),
            ),
            SizedBox(height: appHeight / 3),
            Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateFormModelsScreen()),
                    );
                  },
                  child: Text('Criar Modelo'),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
