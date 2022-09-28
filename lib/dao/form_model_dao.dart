import 'package:collect_app/dao/form_widget_dao.dart';
import 'package:collect_app/models/form_widget.dart';

import '../interfaces/dao_interface.dart';
import '../models/form_model.dart';
import '../services/db_connector.dart';

class FormModelDAO implements DAO<FormModel> {
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
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<int> update(t) {
    // TODO: implement update
    throw UnimplementedError();
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
}
