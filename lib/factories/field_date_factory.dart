import 'package:collect_app/models/form_widget.dart';
import 'package:flutter/material.dart';

import '../../services/db_connector.dart';
import '../widgets/form_widgets/field_date.dart';

class FieldDateFactory {
  late final String _name;

  Future<Widget> makeWidget(int widgetId) async {
    final db = await DataBaseConnector.instance.database;
    // final query = '''
    //     SELECT widgetName
    //     FROM FormWidget
    //     WHERE widgetId = $widgetId;
    // ''';
    final query = '''
        SELECT ${FormWidget.tableColumns['name']}
        FROM ${FormWidget.tableName}
        WHERE ${FormWidget.tableColumns['id']} = $widgetId;
    ''';
    List<Map<String, Object?>> queryResult = await db.rawQuery(query);
    for (var results in queryResult) {
      // if (results.containsKey("widgetName")) {
      //   _name = results['widgetName'] as String;
      // }
      if (results.containsKey(FormWidget.tableColumns['name'])) {
        _name = results[FormWidget.tableColumns['name']] as String;
      }
    }

    return FieldDate(_name);
  }
}
