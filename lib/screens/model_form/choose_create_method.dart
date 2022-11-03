import 'package:collect_app/facades/firestore.dart';

import 'create_form_model.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import 'list_online_models.dart';

class ChooseCreateModelsScreen extends StatefulWidget {
  @override
  State<ChooseCreateModelsScreen> createState() =>
      _ChooseCreateModelsScreenState();
}

class _ChooseCreateModelsScreenState extends State<ChooseCreateModelsScreen> {
  final fireFacade = FirestoreFacade();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(windowTitle: 'Modelos'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateFormModelsScreen()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Criar modelo local',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ListOnlineModelsScreen()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Buscar Modelo Online',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
