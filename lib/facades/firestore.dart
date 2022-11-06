import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect_app/dao/entry_dao.dart';
import 'package:collect_app/models/backup_validation.dart';

import '../dao/backup_validation_dao.dart';
import '../models/entry_value.dart';
import '../models/entry_value_collection.dart';
import '../services/db_firestore.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';

class FirestoreFacade {
  final fireDb = DBFirestore.get();
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
}
