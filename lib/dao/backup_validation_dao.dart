import '../models/backup_validation.dart';
import '../models/entry.dart';
import '../services/db_connector.dart';

class BackupValidationDAO {
  Future<void> add(BackupValidation validation) async {
    final db = await DataBaseConnector.instance.database;
    await db.insert(
      '${BackupValidation.tableName}',
      validation.getData(),
    );
  }

  read(int entryId) async {
    final db = await DataBaseConnector.instance.database;
    final query = '''
      SELECT 
      ${BackupValidation.tableColumns['id']}, 
      ${BackupValidation.tableColumns['userId']},
      ${BackupValidation.tableColumns['docId']}
      FROM ${BackupValidation.tableName}
      WHERE ${Entry.tableColumns['id']} = $entryId;
      ''';
    final queryResult = await db.rawQuery(query);
    for (var result in queryResult) {
      return BackupValidation.fromDB(
        backupId: result['backupId'] as int,
        userId: result['userId'] as String,
        docId: result['docId'] as String,
      );
    }
    return null;
  }

  delete(docId) async {
    final db = await DataBaseConnector.instance.database;
    await db.rawDelete(
      'DELETE FROM ${BackupValidation.tableName} WHERE ${BackupValidation.tableColumns['docId']} = ?',
      [docId],
    );
  }
}
