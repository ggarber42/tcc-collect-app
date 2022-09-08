import 'package:flutter/material.dart';

import '../../interfaces/field_interface.dart';
import '../../services/db_connector.dart';

class FieldText implements Field {
  late final String _name;

  final TextEditingController _textEditingController = TextEditingController();

  Future init(int widgetId) async {
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
  }

  Widget getWidgetBody() {
    return TextFormField(
      controller: _textEditingController,
      decoration: InputDecoration(labelText: _name),
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Esse campo não pode ser nulo';
        }
        return null;
      },
    );
  }
}
