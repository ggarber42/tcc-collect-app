import 'package:flutter/material.dart';

import '../../factories/form_factory.dart';
import '../../services/db_connector.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/base_widgets/main_bar.dart';

class ModelDetailScreen extends StatefulWidget {
  final int modelId;

  ModelDetailScreen(this.modelId);

  @override
  State<ModelDetailScreen> createState() => _ModelDetailScreenState();
}

class _ModelDetailScreenState extends State<ModelDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Widget formBody;
  var fields;

  Future<List<dynamic>> _getFormBody() async {
    var _fields = [];
    final db = await DataBaseConnector.instance.database;
    var query = '''
      SELECT FormWidget.widgetId, type
      FROM FormModel
      INNER JOIN FormWidget
      ON FormModel.modelId = FormWidget.modelId
      WHERE FormWidget.modelId = ${widget.modelId};
    ''';

    List<Map<String, Object?>> queryResult = await db.rawQuery(query);
    var formFactory = FormFactory();
    for (var i = 0; i < queryResult.length; i++) {
      var newField = await formFactory.makeFormWidget(
        queryResult[i]['widgetId'] as int,
        queryResult[i]['type'] as String,
      );
      _fields.add(newField);
    }
    return _fields;
  }

  @override
  void initState() {
    super.initState();
    _getFormBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    for (var i = 0; i < fields.length; i++) {
                      print(fields[i].getInputValue());
                    }
                    if (_formKey.currentState!.validate()) {
                      print('pode');
                    } else {
                      print('nao podeee');
                    }
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}
