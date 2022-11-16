import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

import '../dao/entry_dao.dart';
import '../dao/entry_image_dao.dart';
import '../dao/entry_value_dao.dart';
import '../models/entry.dart';
import '../models/entry_image.dart';

class ShareFacade {
  final entryDao = EntryDAO();
  final valueDao = EntryValueDAO();
  final imageDao = EntryImageDAO();

  Future<dynamic> generateCSVFiles(List<Entry> entries) async {
    List<List<dynamic>> rows = [];
    final firstValues = await valueDao.readAll(entries.first.entryId);
    final header = firstValues.map((value) => value.getName).toList();
    rows.add(header);
    for (var entry in entries) {
      List<dynamic> row = [];
      final entryValues = await valueDao.readAll(entry.entryId);
      for (var entryValue in entryValues) {
        row.add(entryValue.getValue);
      }
      rows.add(row);
    }

    return ListToCsvConverter().convert(rows);
  }

  shareAllValueFieldsFromModel(int modelId) async {
    final entries = await entryDao.readAll(modelId);
    final csv = await generateCSVFiles(entries);
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/values.csv').create();
    await file.writeAsString(csv);
    Share.shareFiles([file.path]);
  }

  shareCSV(csv) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/values.txt').create();
    await file.writeAsString(csv);
    Share.shareFiles([file.path]);
  }

  shareImage(EntryImage entryImage) async {
    Image currentImg = entryImage.getImage;
    MemoryImage memory = currentImg.image as MemoryImage;
    final list = memory.bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file =
        await File('${tempDir.path}/${entryImage.getName}.jpg').create();
    file.writeAsBytesSync(list);
    Share.shareFiles([file.path]);
  }

  shareAllImagesFromModel(int modelId) async {
    final tempDir = await getTemporaryDirectory();
    final entries = [...await entryDao.readAll(modelId)];
    final shareImages = [];
    for (var entry in entries) {
      final images = await imageDao.readAll(entry.entryId);
      for (var image in images) {
        final Image currentImg = image.getImage;
        final MemoryImage memory = currentImg.image as MemoryImage;
        final list = memory.bytes.buffer.asUint8List();
        shareImages.add(
            {'name': '${image.getId}-${image.getName}', 'uint8List': list});
      }
    }
    for (var share in shareImages) {
      final file = await File('${tempDir.path}/${share['name']}.jpg').create();
      file.writeAsBytesSync(share['uint8List']);
    }
    Share.shareFiles(shareImages
        .map((share) => '${tempDir.path}/${share['name']}.jpg')
        .toList());
  }

  shareImageFromNetwork(String imageUrl) async {
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').create();
    file.writeAsBytesSync(bytes);
    Share.shareFiles([file.path]);
  }
}
