import 'package:collect_app/dao/form_model_dao.dart';
import 'package:collect_app/providers/form_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/helper.dart';
import './create_form_model.dart';
import '../../models/form_model.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/model_tile.dart';
import 'edit_form_model.dart';

class ListFormModelsScreen extends StatefulWidget {
  static const routeName = '/list_models';

  @override
  State<ListFormModelsScreen> createState() => _ListFormModelsScreenState();
}

class _ListFormModelsScreenState extends State<ListFormModelsScreen> {
  final modelDao = FormModelDAO();

  deleteModel(int modelId) async {
    final result = await modelDao.delete(modelId);
    if (result == 0) {
      Helper.showWarningDialog(
        context,
        'Modelo possui entradas e não pode ser deletado!',
      );
    } else {
      setState(() {
        Helper.showSnack(context, 'Modelo deletado');
      });
    }
  }

  goToEditScreen(context, modelId, modelName) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFormModelScreen(modelId, modelName),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final models = Provider.of<FormModels>(context, listen: true);
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Collect-app: Modelos',
      ),
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
              return Scrollbar(
                child: ListView.builder(
                  itemCount: models.length,
                  itemBuilder: (ctx, index) =>
                      ModelTile(models[index], deleteModel, goToEditScreen),
                ),
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
              builder: (_) => CreateFormModelsScreen(),
            ),
          );
        },
      ),
    );
  }
}
