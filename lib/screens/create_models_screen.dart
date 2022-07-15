import 'package:collect_app/screens/add_models_widgets_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/main_bar.dart';
import '../widgets/main_drawer.dart';

class CreateModelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MainBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Pesquise por modelos prontos',
                ),
              ),
            ),
            SizedBox(height: appHeight / 3),
            Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddModelsWidgetScreen()),
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
