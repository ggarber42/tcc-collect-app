import 'interface_dao.dart';
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
  }

  @override
  void add(ModelForm model) async {
    final db = await DataBaseConnector.instance.database;
    int modelId = await db.insert('FormModel', model.getFormModelData());
    var fieldList = model.getFieldList();
    var idd;
    for (var i = 0; i < fieldList.length; i++) {
      idd = await db.insert('FormWidget', {
        'widgetName': fieldList[i]['widgetName'],
        'type': fieldList[i]['type'],
        'modelId': modelId
      });
    }
    print(idd);
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
}
