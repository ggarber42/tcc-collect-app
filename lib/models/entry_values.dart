import 'entry.dart';

class EntryValue {
  final int entryValueId;
  final String name;
  final String value;

  static final tableName = 'EntryValue';
  static final tableColumns = {
    'id': 'entryValueId',
    'name': 'name',
    'value': 'value',
    'foreignKey': 'entryValueId'
  };
  static final dropTableQuery = 'DROP TABLE IF EXISTS $tableName';
  static final createTableQuery = '''
        CREATE TABLE IF NOT EXISTS $tableName ( 
          ${tableColumns['id']} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${tableColumns['name']} TEXT NOT NULL,
          ${tableColumns['value']} TEXT NOT NULL,
          ${Entry.tableColumns['id']} INTEGER,
          FOREIGN KEY (${Entry.tableColumns['id']})
          REFERENCES ${Entry.tableName} (${Entry.tableColumns['id']})
    );
  ''';

  EntryValue(this.entryValueId, this.name, this.value);
}
