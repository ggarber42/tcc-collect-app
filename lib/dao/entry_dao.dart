import 'dart:convert';

import 'package:collect_app/dao/backup_validation_dao.dart';
import 'package:collect_app/dao/entry_image_dao.dart';
import 'package:collect_app/dao/entry_value_dao.dart';
import 'package:collect_app/models/backup_validation.dart';

import '../interfaces/dao_interface.dart';
import '../models/entry.dart';
import '../models/entry_image.dart';
import '../models/entry_value.dart';
import '../models/form_model.dart';
import '../services/db_connector.dart';

class EntryDAO implements DAO<Entry> {
  final valueDao = EntryValueDAO();
  final imageDao = EntryImageDAO();
  final validationDao = BackupValidationDAO();

  @override
  Future<void> add(Entry entry) async {
    final db = await DataBaseConnector.instance.database;

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
        ${FormModel.tableColumns['id']}
        FROM ${Entry.tableName}
        WHERE modelId = $modelId;
      ''';
    final queryResult = await db.rawQuery(query);
    for (var result in queryResult) {
      final entryId = result[Entry.tableColumns['id']] as int;
      final backupValidation =
          await validationDao.read(entryId) as BackupValidation?;
      final entryModelName = result[Entry.tableColumns['name']] as String;
      entries.add(Entry.withValidation(
        entryId,
        entryModelName,
        backupValidation,
        result['modelId'] as int
      ));
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
