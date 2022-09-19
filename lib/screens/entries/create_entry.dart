import 'package:flutter/material.dart';

import '../../dao/entry_dao.dart';
import '../../factories/form_factory.dart';
import '../../models/entry_value.dart';
import '../../models/form_widget.dart';
import '../../models/entry.dart';
import '../../models/form_model.dart';
import '../../services/db_connector.dart';
import '../../widgets/base_widgets/name_input.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/base_widgets/main_bar.dart';

class CreateEntryScreen extends StatefulWidget {
  final int modelId;

  CreateEntryScreen(this.modelId);

  @override
  State<CreateEntryScreen> createState() => _CreateEntryScreenState();
}

class _CreateEntryScreenState extends State<CreateEntryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final EntryDAO entryDAO = EntryDAO();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Widget formBody;
  var fields;
  var _controllers = [];

  Future<List<dynamic>> _getFormBody() async {
    var _fields = [];
    final db = await DataBaseConnector.instance.database;
    var formWidgetTableName = FormWidget.tableName;
    var formWidgetTableId = FormWidget.tableColumns['id'];
    var formWidgetTableType = FormWidget.tableColumns['type'];
    var formModelTableName = FormModel.tableName;
    var formModelTableId = FormModel.tableColumns['id'];

    var query = '''
      SELECT  $formWidgetTableName.$formWidgetTableId, $formWidgetTableType
      FROM $formModelTableName
      INNER JOIN $formWidgetTableName
      ON $formModelTableName.$formModelTableId = $formWidgetTableName.$formModelTableId
      WHERE $formWidgetTableName.$formModelTableId =
      ${widget.modelId};
    ''';

    List<Map<String, Object?>> queryResult = await db.rawQuery(query);

    var formFactory = FormFactory();
    for (var i = 0; i < queryResult.length; i++) {
      _controllers.add(TextEditingController());
      var newField = await formFactory.makeFormWidget(
          queryResult[i][formWidgetTableId] as int,
          queryResult[i][formWidgetTableType] as String,
          _controllers[i] as TextEditingController);
      _fields.add(newField);
    }
    return _fields;
  }

  _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        'Entrada criada',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _getFormBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  NameInput(
                    'Nome da entrada*',
                    _nameController,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 35,
                      ),
                      child: FutureBuilder(
                        future: _getFormBody(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            fields = snapshot.data;
                            return ListView.builder(
                              itemCount: fields.length,
                              itemBuilder: (ctx, index) => fields[index],
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: BottomButton('Salvar entrada', () {
                    if (_formKey.currentState!.validate()) {
                      List<EntryValue> values = [];
                      for (var i = 0; i < fields.length; i++) {
                        var fieldValue = fields[i].getInputValue();
                        EntryValue entryValue = EntryValue.fromField(
                          fieldValue['name'],
                          fieldValue['value'],
                        );
                        values.add(entryValue);
                      }
                      entryDAO.add(Entry.withValues(
                        _nameController.value.text,
                        widget.modelId,
                        values as List<EntryValue>,
                      ));
                      _showSnackbar(context);
                    }
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}
