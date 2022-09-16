import 'package:collect_app/models/form_widget.dart';

class RadioOption {
  late final int optionId;
  final String name;
  int? widgetId;

  static final tableName = 'RadioOption';
  static final tableColumns = {
    'id': 'optionId',
    'name': 'name',
  };
  static final String dropTableQuery = 'DROP TABLE IF EXISTS $tableName';
  static final createTableQuery = '''
        CREATE TABLE IF NOT EXISTS $tableName ( 
          ${tableColumns['id']} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${tableColumns['name']} TEXT NOT NULL,
          ${FormWidget.tableColumns['id']} INTEGER,
          FOREIGN KEY (${FormWidget.tableColumns['id']})
          REFERENCES ${FormWidget.tableName} (${FormWidget.tableColumns['id']})
        );
        ''';

  RadioOption(this.name);

  RadioOption.withForeingKey(this.name, this.widgetId);

  Map<String, Object?> getData() {
    return {
      tableColumns['name'] as String: name,
      FormWidget.tableColumns['id'] as String: widgetId,
    };
  }
}
