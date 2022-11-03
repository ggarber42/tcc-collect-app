import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_form_model.dart';
import '../../dao/form_model_dao.dart';
import '../../models/form_model.dart';
import '../../providers/form_models.dart';
import '../../screens/model_form/choose_create_method.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/model_tile.dart';
import '../../utils/helper.dart';

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
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChooseCreateModelsScreen(),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}
