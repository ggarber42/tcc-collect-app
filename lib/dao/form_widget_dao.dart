import 'package:collect_app/dao/radio_option_dao.dart';

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

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<FormWidget>> readAll(int? id) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<int> update(FormWidget t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<dynamic> deleteAll(int modelId) async {
    final db = await DataBaseConnector.instance.database;
    final query = '''
      DELETE FROM ${FormWidget.tableName}
        WHERE ${FormWidget.tableColumns['id']} = $modelId;
      ''';
    final result = await db.rawQuery(query);
    return result;
  }
}
