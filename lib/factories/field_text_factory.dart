import 'package:flutter/material.dart';

import '../../services/db_connector.dart';
import '../widgets/form_widgets/field_text.dart';

class FieldTextFactory {
  late final String _name;

  Future<Widget> makeWidget(int widgetId) async {
    final db = await DataBaseConnector.instance.database;
    final query = '''
        SELECT widgetName
        FROM FormWidget
        WHERE widgetId = $widgetId;
    ''';

    List<Map<String, Object?>> queryResult = await db.rawQuery(query);
    for (var results in queryResult) {
      if (results.containsKey("widgetName")) {
        _name = results['widgetName'] as String;
      }
    }

    return FieldText(_name);
  }
}
