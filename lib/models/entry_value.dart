import 'entry.dart';

class EntryValue {
  int? entryValueId;
  int? entryId;
  final String name;
  final String value;

  static final tableName = 'EntryValue';
  static final tableColumns = {
    'id': 'entryValueId',
    'name': 'name',
    'value': 'value'
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

  EntryValue.fromField(this.name, this.value);

  get getName => name;

  get getValue => value;

  set setEntryId(int id) => entryId = id;

  get getEntryId => entryId;

  Map<String, Object?> getData() {
    return {
      tableColumns['name'] as String: name,
      tableColumns['value'] as String: value,
      Entry.tableColumns['id'] as String: entryId
    };
  }

  Map<String, String> toMap() => {'name': name, 'value': value};
}
