import 'dart:convert';
import 'package:flutter/widgets.dart';

import '../models/entry.dart';
import '../models/entry_image.dart';
import '../services/db_connector.dart';

class EntryImageDAO {
  Future<void> add(EntryImage entryImage) async {
    final db = await DataBaseConnector.instance.database;
    await db.insert(
      '${EntryImage.tableName}',
      entryImage.getData(),
    );
  }

  Future<int> delete(int id) {
    throw UnimplementedError();
  }

  Future<List<EntryImage>> readAll(entryId) async {
    final db = await DataBaseConnector.instance.database;
    List<EntryImage> images = [];
    final query = '''
      SELECT 
        ${EntryImage.tableColumns['id']}, 
        ${EntryImage.tableColumns['name']},
        ${EntryImage.tableColumns['value']}
        FROM ${EntryImage.tableName}
        WHERE ${Entry.tableColumns['id']} = $entryId;
      ''';
    var queryResult = await db.rawQuery(query);
    for (int i = 0; i < queryResult.length; i++) {
      var image = EntryImage(
          queryResult[i][EntryImage.tableColumns['id']] as int,
          queryResult[i][EntryImage.tableColumns['name']] as String,
          queryResult[i][EntryImage.tableColumns['value']] as String);
      image.setImage = Image.memory(
        base64Decode(
          queryResult[i][EntryImage.tableColumns['value']] as String,
        ),
        fit: BoxFit.scaleDown,
      );
      images.add(image);
    }
    return images;
  }

 }
