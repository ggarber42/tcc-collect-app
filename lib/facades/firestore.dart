import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';

import '../dao/backup_validation_dao.dart';
import '../dao/entry_dao.dart';
import '../models/backup_validation.dart';
import '../models/entry_image.dart';
import '../models/entry_value.dart';
import '../models/entry_value_collection.dart';
import '../services/db_firestore.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';

class FirestoreFacade {
  final fireDb = DBFirestore.get();
  final fireRef = FirebaseStorage.instance.ref();
  final entryDao = EntryDAO();
  final validationDao = BackupValidationDAO();

  addBackupFile(
    String userId,
    int entryId,
    String name,
    List<EntryValue> values,
  ) async {
    final docId = Helper.getUuid();
    final userCollect = fireDb.collection(USER_COLLECTION).doc(userId);
    final valueCollect = userCollect.collection(VALUE_COLLECTION).doc(docId);
    final valuesCollection = EntryValueCollection(
      entryName: name,
      values: values,
    );
    await valueCollect.set(valuesCollection.toJson());
    await validationDao.add(BackupValidation.fromFireFacade(
      entryId: entryId,
      userId: userId,
      docId: docId,
    ));
  }

  Stream<List<dynamic>> readBackupValues(String userId) => fireDb
          .collection(USER_COLLECTION)
          .doc(userId)
          .collection(VALUE_COLLECTION)
          .snapshots()
          .map((snapshot) {
        final docs = snapshot.docs
            .map((doc) => {'docId': doc.id, 'data': doc.data()})
            .toList();
        return docs.reversed.toList();
      });

  Future<void> addModelForm(modelData) async {
    final modelCollect = fireDb.collection(MODEL_COLLECTION);
    await modelCollect.add(modelData);
  }

  Future<List<dynamic>> getModels() async {
    final modelCollect = fireDb.collection(MODEL_COLLECTION);
    QuerySnapshot querySnapshot = await modelCollect.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> deleteBackup(String userId, String docId) async {
    final userCollect = fireDb.collection(USER_COLLECTION).doc(userId);
    final valueBackupDoc = userCollect.collection(VALUE_COLLECTION).doc(docId);
    await valueBackupDoc.delete();
    await validationDao.delete(docId);
  }

  uploadImage(EntryImage image, String userId, VoidCallback showFeedback,
      VoidCallback showWarning) async {
    Image currentImg = image.getImage;
    MemoryImage memory = currentImg.image as MemoryImage;
    final list = memory.bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/${image.getName}.jpg').create();
    file.writeAsBytesSync(list);
    final path = 'files/$userId/${image.getName}.jpg';
    final ref = FirebaseStorage.instance.ref().child(path);
    showFeedback();
    ref.putFile(file).whenComplete(() {
      showWarning();
    });
  }

  getImagesFromUser(String userId) async {
    final path = 'files/$userId';
    final ref = fireRef.child(path);
    // final path = 'files/$userId/3x4.jpg';
    // final ref = FirebaseStorage.instance.ref().child(path);
    // final url = await ref.getDownloadURL();
    // print(url);
    ref.listAll().then((result) async {
      final imagePath = result.items[0].fullPath;
      final url = await fireRef.child(imagePath).getDownloadURL();
      print(url);
    });
  }
}
