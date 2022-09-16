import 'package:collect_app/dao/entry_dao.dart';
import 'package:collect_app/models/form_widget.dart';
import 'package:flutter/material.dart';

import '../../factories/form_factory.dart';
import '../../models/entry.dart';
import '../../models/form_model.dart';
import '../../services/db_connector.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/base_widgets/main_bar.dart';

class CreateEntryScreen extends StatefulWidget {
  final int modelId;

  CreateEntryScreen(this.modelId);

  @override
  State<CreateEntryScreen> createState() => _CreateEntryScreenState();
}

class _CreateEntryScreenState extends State<CreateEntryScreen> {
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
                      fields = snapshot.data as List;
                      return Form(
                        key: _formKey,
                        child: ListView.builder(
                          itemCount: fields.length,
                          itemBuilder: (ctx, index) => fields[index],
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: BottomButton('Salvar entrada', () {
                    if (_formKey.currentState!.validate()) {
                      for (var i = 0; i < fields.length; i++) {
                        var fieldValue = fields[i].getInputValue();
                        entryDAO.add(Entry.withForeignKey(
                          fieldValue['name'],
                          widget.modelId,
                        ));
                      }
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
