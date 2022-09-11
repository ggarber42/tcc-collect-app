import 'package:flutter/material.dart';

import '../../dao/model_form_dao.dart';
import '../../models/model_form.dart';
import 'create_models_screen.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/model_tile.dart';

class ListModelsScreen extends StatefulWidget {
  static const routeName = '/list_models';

  @override
  State<ListModelsScreen> createState() => _ListModelsScreenState();
}

class _ListModelsScreenState extends State<ListModelsScreen> {
  Future<List<ModelForm>> _fetchModels() async {
    ModelFormDAO modelDao = ModelFormDAO();
    List<ModelForm> models = [...await modelDao.readAll(null)];
    return models;
  }

  @override
  void initState() {
    super.initState();
    _fetchModels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: FutureBuilder(
          future: _fetchModels(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ModelForm> models = snapshot.data as List<ModelForm>;
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
            MaterialPageRoute(builder: (_) => CreateModelsScreen()),
          );
        },
      ),
    );
  }
}
