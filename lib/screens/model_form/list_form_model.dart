import 'package:flutter/material.dart';

import '../../dao/form_model_dao.dart';
import '../../models/form_model.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/model_tile.dart';
import 'create_form_model.dart';

class ListFormModelsScreen extends StatefulWidget {
  static const routeName = '/list_models';

  @override
  State<ListFormModelsScreen> createState() => _ListFormModelsScreenState();
}

class _ListFormModelsScreenState extends State<ListFormModelsScreen> {
  Future<List<FormModel>> _fetchModels() async {
    FormModelDAO modelDao = FormModelDAO();
    var _;
    List<FormModel> models = [...await modelDao.readAll(_)];
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
            MaterialPageRoute(builder: (_) => CreateFormModelsScreen()),
          );
        },
      ),
    );
  }
}
