import '../interfaces/dao_interface.dart';
import '../models/entry.dart';
import '../services/db_connector.dart';

class EntryDAO implements DAO<Entry> {
  @override
  void add(Entry t) {
    // TODO: implement add
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
      SELECT entryModelId, entryModelName
        FROM Entry
        WHERE modelId = $modelId;
      ''';
    List<Map<String, Object?>> queryResult = await db.rawQuery(query);
    for (int i = 0; i < queryResult.length; i++) {
      var entryModelName = queryResult[i]['name'] as String;
      var entryModelId = queryResult[i]['entryModelId'] as int;
      entries.add(Entry(entryModelId, entryModelName));
    }
    return entries;
  }

  @override
  Future<int> update(Entry t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
