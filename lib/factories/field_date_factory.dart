import 'package:flutter/material.dart';

import '../models/form_widget.dart';
import '../interfaces/field_factory.dart';
import '../widgets/field_widgets/field_date.dart';
import '../../services/db_connector.dart';

class FieldDateFactory implements FieldFactory {
  late int _widgetId;
  late String _name;

  Future<Widget> makeWidget(
    int widgetId,
    TextEditingController controller,
  ) async {
    _widgetId = widgetId;
    final db = await DataBaseConnector.instance.database;
    final query = '''
        SELECT ${FormWidget.tableColumns['name']}
        FROM ${FormWidget.tableName}
        WHERE ${FormWidget.tableColumns['id']} = $widgetId;
    ''';
    List<Map<String, Object?>> queryResult = await db.rawQuery(query);
    for (var results in queryResult) {
      if (results.containsKey(FormWidget.tableColumns['name'])) {
        _name = results[FormWidget.tableColumns['name']] as String;
      }
    }

    return FieldDate(_widgetId, _name, controller);
  }
}
