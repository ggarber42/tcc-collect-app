class ModelForm {
  late int modelId;
  late String modelName;
  static final tableName = 'FormModel';
  static List<String> createTableQuerys = [
    '''
      CREATE TABLE IF NOT EXISTS FormModel ( 
        modelId INTEGER PRIMARY KEY AUTOINCREMENT,
        modelName TEXT NOT NULL
      );
      ''',
    '''
      CREATE TABLE IF NOT EXISTS FormWidget ( 
        widgetId INTEGER PRIMARY KEY AUTOINCREMENT,
        widgetName TEXT NOT NULL,
        type TEXT NOT NULL,
        modelId INTEGER,
        FOREIGN KEY (modelId) REFERENCES FormModel (modelId)
    );
    ''',
    '''
    CREATE TABLE IF NOT EXISTS RadioOption ( 
        optionId INTEGER PRIMARY KEY AUTOINCREMENT,
        optionName TEXT NOT NULL,
        widgetId INTEGER,
        FOREIGN KEY (widgetId) REFERENCES FormWidget (widgetId)
    );
    ''',
    '''
    CREATE TABLE IF NOT EXISTS Entry ( 
        entryId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        modelId INTEGER,
        FOREIGN KEY (modelId) REFERENCES FormModel (modelId)
    );
    ''',
    '''
    CREATE TABLE IF NOT EXISTS EntryValue ( 
        entryValueId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        value TEXT NOT NULL,
        entryId INTEGER,
        FOREIGN KEY (entryId) REFERENCES FormModel (entryId)
    );
    '''
  ];
  static List<String> createTableQuerysx = [
    ''' 
      DROP TABLE IF EXISTS FormModel;
    ''',
    '''
      DROP TABLE IF EXISTS FormWidget;
    ''',
    '''
      DROP TABLE IF EXISTS RadioOptions;
    ''',
    '''
      DROP TABLE IF EXISTS RadioOption;
    ''',
    '''
      DROP TABLE IF EXISTS EntryValue;
    ''',
    '''
      DROP TABLE IF EXISTS EntryModel;
    ''',
    '''
      DROP TABLE IF EXISTS Entry;
    ''',
  ];
  var _fieldList = <Map<String, String>>[];
  var _optionList = <Map<String, String>>[];

  ModelForm(this.modelName);

  ModelForm.fromDB(Map data) {
    modelId = data['modelId'];
    modelName = data['modelName'];
  }

  void addFields(List<dynamic> fieldList) {
    for (var i = 0; i < fieldList.length; i++) {
      _fieldList.add({
        'widgetName': fieldList[i].name,
        'type': fieldList[i].typeValue,
      });
      if (fieldList[i].typeValue == 'radio') {
        for (var j = 0; j < fieldList[i].options.length; j++) {
          _optionList.add({
            'optionName': fieldList[i].options[j],
          });
        }
      }
    }
  }

  String get modelNameValue => modelName;

  Map<String, Object?> getFormModelData() {
    return {
      'modelName': modelName,
    };
  }

  List<Map<String, String>> getFieldList() {
    return _fieldList;
  }

  List<Map<String, String>> getOptionList() {
    return _optionList;
  }
}
