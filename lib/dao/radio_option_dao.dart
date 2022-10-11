import 'package:collect_app/models/radio_option.dart';

import '../interfaces/dao_interface.dart';
import '../models/form_widget.dart';
import '../services/db_connector.dart';

class RadioOptionDAO  {
  @override
  Future<void> add(RadioOption radio) async {
    final db = await DataBaseConnector.instance.database;
    await db.insert(RadioOption.tableName, radio.getData());
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
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

  @override
  Future<int> update(RadioOption t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
