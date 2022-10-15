import 'package:collect_app/dao/form_model_dao.dart';
import 'package:collect_app/dao/form_widget_dao.dart';
import 'package:collect_app/factories/dummy_field_factory.dart';
import 'package:flutter/material.dart';

import '../../dao/radio_option_dao.dart';
import '../../models/form_model.dart';
import '../../models/form_widget.dart';
import '../../models/radio_option.dart';
import '../../services/db_connector.dart';
import '../../utils/helper.dart';
import '../../utils/queries.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/dialog_widgets/dialog_new_field.dart';

class EditFormModelScreen extends StatefulWidget {
  final int modelId;
  final String modelName;

  EditFormModelScreen(
    this.modelId,
    this.modelName,
  );

  @override
  State<EditFormModelScreen> createState() => _EditFormModelScreenState();
}

class _EditFormModelScreenState extends State<EditFormModelScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dummyFactory = DummyFactoryField();
  final modelDao = FormModelDAO();
  final radioDao = RadioOptionDAO();
  final widgetDao = FormWidgetDAO();
  var _hasFetched = false;
  var fields = [];
  var currentWidgets = {};

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.modelName;
    _fetchFields();
  }

  bool _hasFieldsAdded() {
    return fields.length > 0;
  }

  _fetchFields() async {
    var options;
    final db = await DataBaseConnector.instance.database;
    final queryResult = await db.rawQuery(
      Queries.getFieldTypes(widget.modelId),
    );
    for (var result in queryResult) {
      currentWidgets.putIfAbsent(
        result['widgetId'],
        () => {
          'type': result['type'],
        },
      );
      if (result['type'] == 'radio') {
        options = await radioDao.readAll(result['widgetId'] as int);
      }
      fields.add(
        dummyFactory.getFields(result, options),
      );
    }
    setState(() {
      _hasFetched = true;
    });
  }

  _updateModelName() async {
    modelDao.update(
      FormModel.fromEditScreen(
        widget.modelId,
        _textEditingController.value.text,
      ),
    );
  }

  _deleteCurrentWidgets() async {
    currentWidgets.forEach((widgetId, widgetValue) async {
      await widgetDao.delete(widgetId);
      if (widgetValue['tpye'] == 'radio') {
        await radioDao.deleteAll(widgetId);
      }
    });
  }

  _addNewWidgets() async {
    for (var field in fields) {
      final widgetId = await widgetDao.add(
        FormWidget.withModelId(
          field.name,
          field.getType,
          widget.modelId,
        ),
      );
      if (field.getType == 'radio') {
        for (var option in field.options) {
          await radioDao.add(RadioOption.withForeingKey(option, widgetId));
        }
      }
    }
  }

  deleteField(index) {
    fields.removeAt(index);
    setState(() {});
  }

  backButtonClickHandler() async {
    if (_hasFieldsAdded()) {
      bool shouldPop = await Helper.shouldPopDialog(context);
      if (shouldPop) {
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  _handleSubmit() async {
    if (fields.length == 0) {
      Helper.showWarningDialog(context, 'Adicione pelo menos um campo!');
      return;
    }
    if (_formKey.currentState!.validate()) {
      await _updateModelName();
      await _deleteCurrentWidgets();
      await _addNewWidgets();
      Navigator.of(context).pop();
      Helper.showSnack(context, 'Modelo editado!');
    }
  }

  Future _showFieldDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogNewField();
        });
  }

  _makeFields() async {
    final selectedType = await _showFieldDialog(context);
    if (selectedType == null) return;
    final newFormField = await DummyFactoryField().createFormField(
      context,
      selectedType,
    );
    setState(() {
      fields.add(newFormField);
    });
  }

  Widget _widgetList() {
    if (_hasFetched) {
      return Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: fields.length,
          itemBuilder: (ctx, index) =>
              fields[index].getWidgetBody(index, deleteField, context),
        ),
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(  
      onWillPop: () async {
        if (!_hasFieldsAdded()) {
          return true;
        }
        bool shouldPop = await Helper.shouldPopDialog(context);
        if (shouldPop) {
          return true;
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainBar(
          windowTitle: 'Editar modelo',
          hasBackButton: true,
          clickHandler: backButtonClickHandler,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
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
              SingleChildScrollView(
                  child: Container(
                constraints: BoxConstraints(maxHeight: 500),
                child: _widgetList(),
              )),
            ],
          ),
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: FloatingActionButton.extended(
              label: Text("Campo de entrada"),
              icon: Icon(Icons.add),
              onPressed: _makeFields,
            )),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          child: BottomButton('Editar Modelo', _handleSubmit),
        ),
      ),
    );
  }
}
