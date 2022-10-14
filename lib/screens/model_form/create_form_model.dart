import 'package:collect_app/models/form_widget.dart';
import 'package:collect_app/models/radio_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dao/form_model_dao.dart';
import '../../dao/form_widget_dao.dart';
import '../../dao/radio_option_dao.dart';
import '../../factories/dummy_field_factory.dart';
import '../../models/form_model.dart';
import '../../providers/form_models.dart';
import '../../widgets/custom_widgets/main_bar.dart';
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
  final modelFormDao = FormModelDAO();
  final widgetDao = FormWidgetDAO();
  final radioDao = RadioOptionDAO();

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
    final selectedType = await _showFieldDialog(context);
    if (selectedType == null) return;
    final newFormField = await DummyFactoryField().createFormField(
      context,
      selectedType,
    );
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
      final modelForm = FormModel(
        name: _textEditingController.value.text,
      );
      final modelId = await modelFormDao.add(modelForm);
      for (var field in fieldList) {
        final widgetId = await widgetDao.add(
          FormWidget.withModelId(
            field.name,
            field.getType,
            modelId,
          ),
        );
        if (field.getType == 'radio') {
          for (var option in field.options) {
            await radioDao.add(
              RadioOption.withForeingKey(option, widgetId)
            );
          }
        }
      }
      await models.updateModels();
      Helper.showSnack(context, 'Modelo criado');
      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    }
  }

  deleteField(index) {
    fieldList.removeAt(index);
    setState(() {});
  }

  backButtonClickHandler() async {
    bool shouldPop = await Helper.shouldPopDialog(context);
    if (shouldPop) {
      Navigator.of(context).pop(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final models = Provider.of<FormModels>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await Helper.shouldPopDialog(context);
        if (shouldPop) {
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: MainBar(
          windowTitle: 'Novo modelo',
          hasBackButton: true,
          clickHandler: backButtonClickHandler,
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
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 500),
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ListView.builder(
                        itemCount: fieldList.length,
                        itemBuilder: (ctx, index) {
                          return fieldList[index]
                              .getWidgetBody(index, deleteField, context);
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: FloatingActionButton.extended(
              label: Text(
                "Campo de entrada",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              icon: Icon(Icons.add),
              onPressed: () => _handleClick(context)),
        ),
        bottomSheet: Container(
            width: MediaQuery.of(context).size.width,
            child: BottomButton('Salvar Modelo', () => _handleSubmit(models))),
      ),
    );
  }
}
