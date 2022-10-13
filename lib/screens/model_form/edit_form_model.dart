import 'package:collect_app/dao/form_model_dao.dart';
import 'package:collect_app/dao/form_widget_dao.dart';
import 'package:collect_app/factories/dummy_field_factory.dart';
import 'package:flutter/material.dart';

import '../../dao/radio_option_dao.dart';
import '../../models/form_model.dart';
import '../../services/db_connector.dart';
import '../../utils/helper.dart';
import '../../utils/queries.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/custom_widgets/main_bar.dart';

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
  var _fields = [];

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.modelName;
  }

  _fetchFields() async {
    var fields = [];
    var options;
    final db = await DataBaseConnector.instance.database;
    final queryResult = await db.rawQuery(
      Queries.getFieldTypes(widget.modelId),
    );
    for (var result in queryResult) {
      if (result['type'] == 'radio') {
        options = await radioDao.readAll(result['widgetId'] as int);
      }
      fields.add(dummyFactory.getFields(result, options));
    }
    return fields;
  }

  _updateWidgets() async {
    for (var field in _fields) {
      print(field.getId);
      // await widgetDao.update(field.getId);
    }
  }

  _updateModelName() async {
    modelDao.update(
      FormModel.fromEditScreen(
        widget.modelId,
        _textEditingController.value.text,
      ),
    );
  }

  _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      await _updateModelName();
      // await _updateWidgets();
      Navigator.of(context).pop();
      Helper.showSnack(context, 'Modelo editado!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Editar modelo',
        hasBackButton: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
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
            SingleChildScrollView(
                child: Container(
              child: FutureBuilder(
                future: _fetchFields(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var fields = snapshot.data as List;
                    _fields = fields;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: fields.length,
                      itemBuilder: (ctx, index) =>
                          fields[index].getWidgetBody(),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: FloatingActionButton.extended(
            label: Text("Campo de entrada"),
            icon: Icon(Icons.add),
            onPressed: () {},
          )),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: BottomButton('Editar Modelo', _handleSubmit),
      ),
    );
  }
}
