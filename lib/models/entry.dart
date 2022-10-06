import 'package:collect_app/models/entry_image.dart';

import 'entry_value.dart';
import 'form_model.dart';

class Entry {
  final String name;
  int? entryId;
  int? modelId;
  List<EntryValue>? values;
  List<EntryImage>? images;

  static final tableName = 'Entry';
  static final tableColumns = {
    'id': 'entryId',
    'name': 'name',
  };
  static final dropTableQuery = 'DROP TABLE IF EXISTS $tableName';
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

  Entry.withValues(this.name, this.modelId, this.values, this.images);

  get getName => name;

  get getId => entryId as int;

  get getValues => values as List<EntryValue>;

  get getImages => images as List<EntryImage>;

  Map<String, Object?> getData() {
    return {
      tableColumns['name'] as String: name,
      FormModel.tableColumns['id'] as String: modelId
    };
  }
}
