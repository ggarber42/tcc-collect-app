import 'form_widget.dart';
import 'radio_option.dart';

class FormModel {
  late int modelId;

  String? name;
  var _fieldList = <Map<String?, String>>[];
  var _optionList = [];

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

  FormModel({required this.name});

  FormModel.fromDB(Map data) {
    modelId = data[tableColumns['id']];
    name = data[tableColumns['name']];
  }

  FormModel.fromEditScreen(this.modelId, this.name);

  get getModelId => modelId;

  set setModelId(int value) => modelId = value;

  get getName => this.name;

  void removeField() {}

  Map<String, Object?> getData() {
    return {
      'name': name,
    };
  }

  List<Map<String?, String>> getFieldList() {
    return _fieldList;
  }

  getOptionList() {
    return _optionList;
  }
}
