import '../../models/entry.dart';

class BackupValidation {
  final String userId;
  final String docId;
  int? backupId;
  int? entryId;

  static final tableName = 'BackupValidation';
  static final tableColumns = {
    'id': 'backupId',
    'userId': 'userId',
    'docId': 'docId'
  };
  static final dropTableQuery = 'DROP TABLE IF EXISTS $tableName';
  static final createTableQuery = '''
        CREATE TABLE IF NOT EXISTS $tableName ( 
          ${tableColumns['id']} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${tableColumns['userId']} TEXT NOT NULL,
          ${tableColumns['docId']} TEXT NOT NULL,
          ${Entry.tableColumns['id']} INTEGER,
          FOREIGN KEY (${Entry.tableColumns['id']})
          REFERENCES ${Entry.tableName} (${Entry.tableColumns['id']})
    );
    ''';

  BackupValidation(this.userId, this.docId);

  BackupValidation.fromDB(
      {required this.backupId,
      required this.docId,
      required this.userId});

  BackupValidation.fromFireFacade({
    required this.entryId,
    required this.docId,
    required this.userId
  });

  get getUserId => userId;
  get getDocId => docId;

  Map<String, Object?> getData() {
    return {
      tableColumns['userId'] as String: userId,
      tableColumns['docId'] as String: docId,
      Entry.tableColumns['id'] as String: entryId
    };
  }
}
