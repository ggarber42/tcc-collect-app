import 'package:collect_app/models/form_widget.dart';
import 'package:flutter/material.dart';

import '../interfaces/field_factory.dart';
import '../widgets/field_widgets/field_text.dart';
import '../../services/db_connector.dart';

class FieldTextFactory implements FieldFactory {
  late int _widgetId;
  late String _name;
  late TextEditingController _controller;

  Future<Widget> makeWidget(
      int widgetId, TextEditingController controller) async {
    _controller = controller;
    _widgetId = widgetId;
    final db = await DataBaseConnector.instance.database;
    final query = '''
        SELECT ${FormWidget.tableColumns['name']}
        FROM ${FormWidget.tableName}
        WHERE widgetId = $widgetId;
    ''';

    List<Map<String, Object?>> queryResult = await db.rawQuery(query);
    for (var results in queryResult) {
      if (results.containsKey(FormWidget.tableColumns['name'])) {
        _name = results[FormWidget.tableColumns['name']] as String;
      }
    }

    return FieldText(_widgetId ,_name, _controller);
  }
}
