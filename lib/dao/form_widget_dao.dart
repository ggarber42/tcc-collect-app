import 'package:collect_app/dao/radio_option_dao.dart';

import '../models/form_model.dart';
import '../models/form_widget.dart';
import '../services/db_connector.dart';

class FormWidgetDAO {
  final radioDao = RadioOptionDAO();

  Future<int> add(FormWidget formWidget) async {
    final db = await DataBaseConnector.instance.database;
    return await db.insert(
      '${FormWidget.tableName}',
      formWidget.getData(),
    );
  }

  Future<int> delete(int widgetId) async {
    final db = await DataBaseConnector.instance.database;
    return await db.delete(
      FormWidget.tableName,
      where: '${FormWidget.tableColumns['id'] as String}=?',
      whereArgs: [widgetId],
    );
  }

  Future<dynamic> deleteAll(int modelId) async {
    final db = await DataBaseConnector.instance.database;
    final query = '''
      SELECT ${FormWidget.tableColumns['id']}, ${FormWidget.tableColumns['type']}
      FROM ${FormWidget.tableName}
      WHERE ${FormModel.tableColumns['id']} = $modelId;
      ''';
    final queryResult = await db.rawQuery(query);
    for (var result in queryResult) {
      await db.delete(
        FormWidget.tableName,
        where: '${FormWidget.tableColumns['id'] as String}=?',
        whereArgs: [result['widgetId']],
      );
      if (result['type'] == 'radio') {
        await radioDao.deleteAll(result['widgetId'] as int);
      }
    }
    return 1;
  }
}
