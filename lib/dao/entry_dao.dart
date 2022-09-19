import 'package:collect_app/dao/entry_value_dao.dart';
import 'package:collect_app/models/entry_value.dart';

import '../interfaces/dao_interface.dart';
import '../models/entry.dart';
import '../services/db_connector.dart';

class EntryDAO implements DAO<Entry> {
  @override
  Future<void> add(Entry entry) async {
    final db = await DataBaseConnector.instance.database;
    EntryValueDAO valueDao = EntryValueDAO();
    final int entryId = await db.insert(
      '${Entry.tableName}',
      entry.getData(),
    );
    List<EntryValue> values = entry.getValues;
    for (var i = 0; i < values.length; i++) {
      values[i].setEntryId = entryId;
      valueDao.add(values[i]);
    }
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Entry>> readAll(int? modelId) async {
    final db = await DataBaseConnector.instance.database;
    List<Entry> entries = [];
    final query = '''
      SELECT ${Entry.tableColumns['id']}, ${Entry.tableColumns['name']}
        FROM ${Entry.tableName}
        WHERE modelId = $modelId;
      ''';
    List<Map<String, Object?>> queryResult = await db.rawQuery(query);
    for (int i = 0; i < queryResult.length; i++) {
      var entryModelName = queryResult[i][Entry.tableColumns['name']] as String;
      var entryId = queryResult[i][Entry.tableColumns['id']] as int;
      entries.add(Entry.withId(entryId, entryModelName));
    }
    return entries;
  }

  @override
  Future<int> update(Entry t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
