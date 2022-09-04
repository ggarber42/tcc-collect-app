import 'package:flutter/material.dart';

import '../../services/db_connector.dart';

class FormBody extends StatefulWidget {
  final int modelId;

  FormBody(this.modelId);

  @override
  State<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  late Widget formBody;

  void _getFormBody() async {
    final db = await DataBaseConnector.instance.database;
    var query = '''
      SELECT FormWidget.widgetId, widgetName, type, optionName
      FROM FormWidget
      INNER JOIN RadioOptions 
      ON FormWidget.widgetId = RadioOptions.widgetId;
    ''';
    print('oieeeee');
    print(widget.modelId);
    // var teste = await db.rawQuery(query);
    // print(teste);
  }

  @override
  void initState() {
    super.initState();
    _getFormBody();
  }

  @override
  Widget build(BuildContext context) {
    return Text('aquiii');
  }
}
