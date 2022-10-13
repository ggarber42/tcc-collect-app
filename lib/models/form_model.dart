import 'form_widget.dart';
import 'radio_option.dart';

class FormModel {
  late int modelId;

  late String name;
  var _fieldList = <Map<String?, String>>[];
  var _optionList = <Map<String?, String>>[];

  static final tableName = 'FormModel';
  static final tableColumns = {
    'id': 'modelId',
    'name': 'name',
  };
  static final dropTableQuery = 'DROP TABLE IF EXISTS $tableName';
  static final createTableQuery = '''
      CREATE TABLE IF NOT EXISTS $tableName ( 
        ${tableColumns['id']} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${tableColumns['name']} TEXT NOT NULL
      );
  ''';

  FormModel(this.name);

  FormModel.fromDB(Map data) {
    modelId = data[tableColumns['id']];
    name = data[tableColumns['name']];
  }

  FormModel.fromEditScreen(this.modelId, this.name);

  get getModelId => modelId;

  set setModelId(int value) => modelId = value;

  get getName => this.name;

  void addFields(List<dynamic> fieldList) {
    for (var i = 0; i < fieldList.length; i++) {
      _fieldList.add({
        FormWidget.tableColumns['name']: fieldList[i].name,
        FormWidget.tableColumns['type']: fieldList[i].getType,
      });
      if (fieldList[i].getType == 'radio') {
        for (var j = 0; j < fieldList[i].options.length; j++) {
          _optionList.add({
            RadioOption.tableColumns['name']: fieldList[i].options[j],
          });
        }
      }
    }
  }

  Map<String, Object?> getData() {
    return {
      'name': name,
    };
  }

  List<Map<String?, String>> getFieldList() {
    return _fieldList;
  }

  List<Map<String?, String>> getOptionList() {
    return _optionList;
  }
}
