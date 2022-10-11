import '../interfaces/dao_interface.dart';
import '../models/entry.dart';
import '../models/entry_value.dart';
import '../services/db_connector.dart';

class EntryValueDAO implements DAO<EntryValue> {
  @override
  Future<void> add(EntryValue entryValue) async {
    final db = await DataBaseConnector.instance.database;
    await db.insert(
      '${EntryValue.tableName}',
      entryValue.getData(),
    );
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<EntryValue>> readAll(entryId) async {
    final db = await DataBaseConnector.instance.database;
    List<EntryValue> values = [];
    final query = '''
      SELECT ${EntryValue.tableColumns['id']}, ${EntryValue.tableColumns['name']}, ${EntryValue.tableColumns['value']}
        FROM ${EntryValue.tableName}
        WHERE ${Entry.tableColumns['id']} = $entryId;
      ''';
    var queryResult = await db.rawQuery(query);
    for (int i = 0; i < queryResult.length; i++) {
      values.add(
        EntryValue(
          queryResult[i][EntryValue.tableColumns['id']] as int,
          queryResult[i][EntryValue.tableColumns['name']] as String,
          queryResult[i][EntryValue.tableColumns['value']] as String,
        ),
      );
    }
    return values;
  }

  Future<dynamic> deleteAll(entryId) async {
    final db = await DataBaseConnector.instance.database;
    final query = '''
      DELETE FROM ${EntryValue.tableName}
        WHERE ${Entry.tableColumns['id']} = $entryId;
      ''';
    final result = await db.rawQuery(query);
    return result;
  }

  @override
  Future<int> update(EntryValue t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
