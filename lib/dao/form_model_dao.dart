import 'package:collect_app/dao/form_widget_dao.dart';
import 'package:collect_app/models/form_widget.dart';

import '../interfaces/dao_interface.dart';
import '../models/form_model.dart';
import '../services/db_connector.dart';
import 'entry_dao.dart';

class FormModelDAO  {
  final entryDao = EntryDAO();
  final widgetDao = FormWidgetDAO();

  Future<bool> _hasEntries(int modelId) async {
    var entries = await entryDao.readAll(modelId);
    if (entries.length > 0) {
      return true;
    }
    return false;
  }

  @override
  Future<void> add(FormModel model) async {
    final db = await DataBaseConnector.instance.database;
    int modelId = await db.insert(
      FormModel.tableName,
      model.getData(),
    );
    model.setModelId = modelId;
    List<Map<String?, String>> fieldList = model.getFieldList();
    final formWidgetName = FormWidget.tableColumns['name'];
    final formWidgetType = FormWidget.tableColumns['type'];
    for (var i = 0; i < fieldList.length; i++) {
      FormWidget formWidget = FormWidget.withModel(
        fieldList[i][formWidgetName] as String,
        fieldList[i][formWidgetType] as String,
        model,
      );
      FormWidgetDAO formWidgetDao = FormWidgetDAO();
      formWidgetDao.add(formWidget);
    }
  }

  @override
  Future<int> delete(int modelId) async {
    final hasEntries = await _hasEntries(modelId);
    if (hasEntries) {
      return 0;
    }
    final db = await DataBaseConnector.instance.database;
    await widgetDao.deleteAll(modelId);
    return await db.delete(
      FormModel.tableName,
      where: '${FormModel.tableColumns['id'] as String}=?',
      whereArgs: [modelId],
    );
  }


   Future<int> update(FormModel model) async {
    final db = await DataBaseConnector.instance.database;
    return await db.update(
      FormModel.tableName,
      model.getData(),
      where: '${FormModel.tableColumns['id'] as String}=?',
      whereArgs: [model.getModelId],
    );
  }

  @override
  Future<List<FormModel>> readAll(_) async {
    final db = await DataBaseConnector.instance.database;
    List<FormModel> models = [];
    List<Map<String, Object?>> queryResult = await db.query(
      FormModel.tableName,
      columns: [
        FormModel.tableColumns['id'] as String,
        FormModel.tableColumns['name'] as String,
      ],
    );
    for (int i = 0; i < queryResult.length; i++) {
      models.add(FormModel.fromDB(queryResult[i]));
    }
    return models;
  }

  Future<FormModel> read(int modelId) async {
    final db = await DataBaseConnector.instance.database;
    var queryResult = await db.query(
      FormModel.tableName,
      where: '${FormModel.tableColumns['id'] as String}=?',
      whereArgs: [modelId],
      limit: 1,
    );
    var model;
    queryResult.forEach(
      (result) {
        model = FormModel.fromDB(result);
      },
    );
    return model as FormModel;
  }
}
