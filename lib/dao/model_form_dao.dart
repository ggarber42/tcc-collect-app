import '../interfaces/dao_interface.dart';
import '../models/model_form.dart';
import '../services/db_connector.dart';

class ModelFormDAO implements DAO<ModelForm> {
  ModelFormDAO() {
    _createModelFormTable();
  }

  void _createModelFormTable() async {
    final db = await DataBaseConnector.instance.database;
    for (var i = 0; i < ModelForm.createTableQuerys.length; i++) {
      await db.execute(ModelForm.createTableQuerys[i]);
    }
    final tables =
        await db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
    // print(tables);
  }

  @override
  void add(ModelForm model) async {
    final db = await DataBaseConnector.instance.database;
    int modelId = await db.insert('FormModel', model.getFormModelData());
    var fieldList = model.getFieldList();
    int widgetId;
    for (var i = 0; i < fieldList.length; i++) {
      widgetId = await db.insert('FormWidget', {
        'widgetName': fieldList[i]['widgetName'],
        'type': fieldList[i]['type'],
        'modelId': modelId
      });
      if (fieldList[i]['type'] == 'radio') {
        var optionList = model.getOptionList();
        for (var i = 0; i < optionList.length; i++) {
          await db.insert('RadioOptions', {
            'optionName': optionList[i]['optionName'],
            'widgetId': widgetId,
          });
        }
      }
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
  Future<List<ModelForm>> readAll() async {
    final db = await DataBaseConnector.instance.database;
    List<ModelForm> models = [];
    List<Map<String, Object?>> queryResult = await db.query(
      ModelForm.tableName,
      columns: ['modelId', 'modelName'],
    );
    for (int i = 0; i < queryResult.length; i++) {
      models.add(ModelForm.fromDB(queryResult[i]));
    }
    return models;
  }
}
