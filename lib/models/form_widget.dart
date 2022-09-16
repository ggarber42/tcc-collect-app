import 'form_model.dart';

class FormWidget {
  late final int widgetId;
  final String name;
  final String type;

  FormModel? model;

  static final tableName = 'FormWidget';
  static final String dropTableQuery = 'DROP TABLE IF EXISTS $tableName';
  static final tableColumns = {
    'id': 'widgetId',
    'name': 'name',
    'type': 'type'
  };
  static final createTableQuery = '''
        CREATE TABLE IF NOT EXISTS $tableName ( 
          ${tableColumns['id']} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${tableColumns['name']} TEXT NOT NULL,
          ${tableColumns['type']} TEXT NOT NULL,
          ${FormModel.tableColumns['id']} INTEGER,
          FOREIGN KEY (${FormModel.tableColumns['id']}) 
          REFERENCES ${FormModel.tableName} (${FormModel.tableColumns['id']})
    );
  ''';

  FormWidget(this.widgetId, this.name, this.type);

  FormWidget.withModel(this.name, this.type, this.model);

  get getType => type;

  get getModel => model;

  Map<String, Object?> getData() {
    return {
      tableColumns['name'] as String: name,
      tableColumns['type'] as String: type,
      FormModel.tableColumns['id'] as String: model!.getModelId
    };
  }

  getNameData() {
    return {
      tableColumns['name']: name,
    };
  }

  getTypeData() {
    return {
      tableColumns['type']: type,
    };
  }

  getModelData() {
    return {
      FormModel.tableColumns['id']: model,
    };
  }

  getOptionList() {
    return model!.getOptionList();
  }
}
