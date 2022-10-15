import 'package:collect_app/models/radio_option.dart';

import '../models/form_widget.dart';
import '../services/db_connector.dart';

class RadioOptionDAO {
  Future<void> add(RadioOption radio) async {
    final db = await DataBaseConnector.instance.database;
    await db.insert(RadioOption.tableName, radio.getData());
  }

  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<List<Map<dynamic, dynamic>>> readAll(int? widgetId) async {
    final db = await DataBaseConnector.instance.database;
    final fetchOptionsQuery = '''
      SELECT ${RadioOption.tableColumns['id']}, 
        ${RadioOption.tableColumns['name']}
        FROM ${RadioOption.tableName}
        WHERE ${FormWidget.tableColumns['id']} = $widgetId;
      ''';
    final queryOptionResult = await db.rawQuery(fetchOptionsQuery);
    return queryOptionResult;
  }

  Future<int> update(RadioOption t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  deleteAll(int widgetId) async {
    final db = await DataBaseConnector.instance.database;
    final query = '''
      DELETE FROM ${RadioOption.tableName}
        WHERE ${FormWidget.tableColumns['id']} = $widgetId;
      ''';
    final result = await db.rawQuery(query);
    return result;
  }
}
