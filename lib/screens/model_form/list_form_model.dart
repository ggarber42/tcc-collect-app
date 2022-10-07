import 'package:collect_app/providers/form_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './create_form_model.dart';
import '../../models/form_model.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/model_tile.dart';

class ListFormModelsScreen extends StatefulWidget {
  static const routeName = '/list_models';

  @override
  State<ListFormModelsScreen> createState() => _ListFormModelsScreenState();
}

class _ListFormModelsScreenState extends State<ListFormModelsScreen> {

  @override
  Widget build(BuildContext context) {
    final models = Provider.of<FormModels>(context, listen: true);
    return Scaffold(
      appBar: MainBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: FutureBuilder(
          future: models.getModels,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<FormModel> models = snapshot.data as List<FormModel>;
              return ListView.builder(
                itemCount: models.length,
                itemBuilder: (ctx, index) => ModelTile(models[index]),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Modelo"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CreateFormModelsScreen()),
          );
        },
      ),
    );
  }
}
