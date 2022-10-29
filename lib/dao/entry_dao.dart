import 'dart:convert';

import 'package:collect_app/dao/entry_image_dao.dart';
import 'package:collect_app/dao/entry_value_dao.dart';

import '../interfaces/dao_interface.dart';
import '../models/entry.dart';
import '../models/entry_image.dart';
import '../models/entry_value.dart';
import '../services/db_connector.dart';

class EntryDAO implements DAO<Entry> {
  final valueDao = EntryValueDAO();

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
  Future<int> delete(int entryId) async {
    final db = await DataBaseConnector.instance.database;
    await valueDao.deleteAll(entryId);
    return await db.delete(
      Entry.tableName,
      where: '${Entry.tableColumns['id'] as String}=?',
      whereArgs: [entryId],
    );
  }

  @override
  Future<List<Entry>> readAll(int? modelId) async {
    final db = await DataBaseConnector.instance.database;
    List<Entry> entries = [];
    final query = '''
        SELECT
        ${Entry.tableColumns['id']}, 
        ${Entry.tableColumns['name']},
        ${Entry.tableColumns['docValuesId']}
        FROM ${Entry.tableName}
        WHERE modelId = $modelId;
      ''';
    final queryResult = await db.rawQuery(query);
    for (var result in queryResult) {
      final docValuesId = result[Entry.tableColumns['docValuesId']] as String?;
      final entryModelName = result[Entry.tableColumns['name']] as String;
      final entryId = result[Entry.tableColumns['id']] as int;
      entries.add(Entry.withId(entryId, entryModelName, docValuesId));
    }
    return entries;
  }

  addDocValuesId(int entryId, String docValuesId) async {
    final db = await DataBaseConnector.instance.database;
    await db.rawUpdate(
      '''
      UPDATE ${Entry.tableName}
      SET ${Entry.tableColumns['docValuesId']} = ? 
      WHERE ${Entry.tableColumns['id']} = ?''',
      [docValuesId, entryId],
    );
  }

  deleteDocValuesId(String docValuesId) async {
    final db = await DataBaseConnector.instance.database;
    final count = await db.rawUpdate(
      '''
      UPDATE ${Entry.tableName}
      SET ${Entry.tableColumns['docValuesId']} = ? 
      WHERE ${Entry.tableColumns['docValuesId']} = ?''',
      [null, docValuesId],
    );
  }

  @override
  Future<int> update(Entry t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
