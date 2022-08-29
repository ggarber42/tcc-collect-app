class ModelForm {
  late String modelName;
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
    '''
  ];
  static List<String> createTableQuerysx = [
    ''' 
      DROP TABLE IF EXISTS FormModel
    ''',
    '''
      DROP TABLE IF EXISTS FormWidget;
    '''
  ];
  var _fieldList = <Map<String, String>>[];

  ModelForm(this.modelName);

  void addFields(List<dynamic> fieldList) {
    for (var i = 0; i < fieldList.length; i++) {
      _fieldList.add({
        'widgetName': fieldList[i].name,
        'type': fieldList[i].type,
      });
    }
  }

  Map<String, Object?> getFormModelData() {
    return {
      'modelName': modelName,
    };
  }

  List<Map<String, String>> getFieldList() {
    return _fieldList;
  }
  // Map<String, Object?> makeFormWidgetData(int id) {
  //   return {
  //     'widgetName': modelName,
  //     'type': modelName,
  //     'modelName': modelName,
  //   };
  // }
}
