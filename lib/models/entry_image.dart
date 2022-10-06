import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

import 'entry.dart';

class EntryImage {
  final String name;
  int? entryImageId;
  int? entryId;
  XFile? imageFile;
  Image? image;
  String? value;

  static final tableName = 'EntryImage';
  static final tableColumns = {
    'id': 'entryImageId',
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

  EntryImage(this.entryImageId, this.name, this.value);

  EntryImage.fromField(this.name, this.imageFile);

  get getName => name;

  get getValue => value;

  get getImageFile => imageFile;

  get path => imageFile!.path;

  set setEntryId(int id) => entryId = id;

  set setValue(String newValue) => value = newValue;

  get getEntryId => entryId;

  set setImage(newImage) => image = newImage;

  get getImage => image;

  Map<String, Object?> getData() {
    return {
      tableColumns['name'] as String: name,
      tableColumns['value'] as String: value,
      Entry.tableColumns['id'] as String: entryId
    };
  }
}
