import 'package:flutter/material.dart';

import '../../services/db_connector.dart';
import '../widgets/form_widgets/field_radio.dart';
import '../widgets/form_widgets/field_text.dart';

class FieldRadioFactory {
  late final String _name;
  final _options = [];

  Future<Widget> makeWidget(int widgetId) async {
    final db = await DataBaseConnector.instance.database;
    final fetchNameQuery = '''
        SELECT widgetName
        FROM FormWidget
        WHERE widgetId = $widgetId;
    ''';
    final fetchOptionsQuery = '''
      SELECT optionId, optionName
        FROM RadioOptions
        WHERE widgetId = $widgetId;
      ''';
    List<Map<String, Object?>> queryNameResult =
        await db.rawQuery(fetchNameQuery);
    List<Map<String, Object?>> queryOptionResult =
        await db.rawQuery(fetchOptionsQuery);

    for (var nameResult in queryNameResult) {
      if (nameResult.containsKey("widgetName")) {
        _name = nameResult['widgetName'] as String;
      }
    }

    for (var optionResult in queryOptionResult) {
      _options.add(optionResult);
    }

    return FieldRadio(_name, _options);
  }
}
