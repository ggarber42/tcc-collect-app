import 'form_model.dart';

class Entry {
  final String name;
  int? entryId;
  int? modelId;
  static final tableName = 'Entry';
  static final tableColumns = {
    'id': 'entryId',
    'name': 'name',
  };
  static final String dropTableQuery = 'DROP TABLE IF EXISTS $tableName';
  static final createTableQuery = '''
        CREATE TABLE IF NOT EXISTS $tableName ( 
          ${tableColumns['id']} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${tableColumns['name']} TEXT NOT NULL,
          ${FormModel.tableColumns['id']} INTEGER,
          FOREIGN KEY (${FormModel.tableColumns['id']})
          REFERENCES ${FormModel.tableName} (${FormModel.tableColumns['id']})
    );
    ''';

  Entry(this.name);

  Entry.withId(this.entryId, this.name);

  Entry.withForeignKey(this.name, this.modelId);

  String get getName => name;

  Map<String, Object?> getData() {
    return {
      tableColumns['name'] as String: name,
      FormModel.tableColumns['id'] as String: modelId
    };
  }
}
