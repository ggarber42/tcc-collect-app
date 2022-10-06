import 'dart:convert';

import 'package:collect_app/dao/entry_image_dao.dart';
import 'package:collect_app/dao/entry_value_dao.dart';

import '../interfaces/dao_interface.dart';
import '../models/entry.dart';
import '../models/entry_image.dart';
import '../models/entry_value.dart';
import '../services/db_connector.dart';

class EntryDAO implements DAO<Entry> {
  @override
  Future<void> add(Entry entry) async {
    final db = await DataBaseConnector.instance.database;
    EntryValueDAO valueDao = EntryValueDAO();
    EntryImageDAO imageDao = EntryImageDAO();

    final int entryId = await db.insert(
      '${Entry.tableName}',
      entry.getData(),
    );
    List<EntryValue> values = entry.getValues;
    for (var i = 0; i < values.length; i++) {
      values[i].setEntryId = entryId;
      valueDao.add(values[i]);
    }
    List<EntryImage> images = entry.getImages;
    for (var i = 0; i < images.length; i++) {
      var bytes = await images[i].getImageFile.readAsBytes();
      var encondedImage = base64Encode(bytes);
      images[i].setValue = encondedImage;
      images[i].setEntryId = entryId;
      imageDao.add(images[i]);
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
