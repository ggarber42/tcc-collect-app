import 'package:collect_app/models/form_widget.dart';
import 'package:collect_app/models/radio_option.dart';
import 'package:flutter/material.dart';

import '../../services/db_connector.dart';
import '../interfaces/field_factory.dart';
import '../widgets/field_widgets/field_radio.dart';

class FieldRadioFactory implements FieldFactory {
  late int _widgetId;
  late final String _name;
  final _options = [];

  Future<Widget> makeWidget(
    int widgetId,
    TextEditingController controller,
  ) async {
    _widgetId = widgetId;
    final db = await DataBaseConnector.instance.database;
    final fetchNameQuery = '''
        SELECT ${FormWidget.tableColumns['name']}
        FROM ${FormWidget.tableName}
        WHERE ${FormWidget.tableColumns['id']} = $widgetId;
    ''';
    final fetchOptionsQuery = '''
      SELECT ${RadioOption.tableColumns['id']}, 
        ${RadioOption.tableColumns['name']}
        FROM ${RadioOption.tableName}
        WHERE ${FormWidget.tableColumns['id']} = $widgetId;
      ''';
    List<Map<String, Object?>> queryNameResult =
        await db.rawQuery(fetchNameQuery);
    List<Map<String, Object?>> queryOptionResult =
        await db.rawQuery(fetchOptionsQuery);

    for (var nameResult in queryNameResult) {
      if (nameResult.containsKey(RadioOption.tableColumns['name'])) {
        _name = nameResult[RadioOption.tableColumns['name']] as String;
      }
    }
    for (var optionResult in queryOptionResult) {
      _options.add(optionResult);
    }

    return FieldRadio(_widgetId, _name, _options, controller);
  }
}
