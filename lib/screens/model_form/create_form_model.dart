import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dao/form_model_dao.dart';
import '../../factories/dummy_field_factory.dart';
import '../../models/form_model.dart';
import '../../providers/form_models.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/base_widgets/main_drawer.dart';
import '../../widgets/dialog_widgets/dialog_new_field.dart';
import '../../utils/helper.dart';

class CreateFormModelsScreen extends StatefulWidget {
  static const routeName = '/add-fields';

  CreateFormModelsScreen();

  @override
  _CreateFormModelsScreenState createState() => _CreateFormModelsScreenState();
}

class _CreateFormModelsScreenState extends State<CreateFormModelsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var fieldList = [];

  Future _showFieldDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogNewField();
        });
  }

  _handleClick(BuildContext context) async {
    var selectedType = await _showFieldDialog(context);
    if (selectedType == null) return;
    var newFormField =
        await DummyFactoryField().createFormField(context, selectedType);
    setState(() {
      fieldList.add(newFormField);
    });
  }

  _handleSubmit(models) async {
    var hasFieldAdded = fieldList.length > 0;
    if (!hasFieldAdded) {
      Helper.showWarningDialog(context, 'Adicione pelo menos um campo!');
      return;
    }
    if (_formKey.currentState!.validate() && hasFieldAdded) {
      var modelName = _textEditingController.value.text;
      var modelForm = FormModel(modelName);

      modelForm.addFields(fieldList);
      FormModelDAO modelFormDao = FormModelDAO();

      await modelFormDao.add(modelForm);
      await models.updateModels();
      Helper.showSnack(context, 'Modelo criado');
      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final models = Provider.of<FormModels>(context, listen: false);
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Novo modelo',
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _textEditingController,
                    decoration: InputDecoration(labelText: 'Nome do modelo *'),
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Esse campo não pode ser nulo';
                      }
                      return null;
                    },
                  ),
                )),
            SingleChildScrollView(
              child: Container(
                height: 400,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: ListView.builder(
                    itemCount: fieldList.length,
                    itemBuilder: (ctx, index) {
                      return fieldList[index].getWidgetBody();
                    }),
              ),
            )
          ],
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
            label: Text("Campo de entrada"),
            icon: Icon(Icons.add),
            onPressed: () => _handleClick(context)),
      ),
      bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          child: BottomButton(
              'Salvar Modelo', () => _handleSubmit(models))),
    );
  }
}
