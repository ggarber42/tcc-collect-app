import '../models/entry.dart';
import '../models/entry_values.dart';
import '../models/form_model.dart';
import '../models/form_widget.dart';
import '../models/radio_option.dart';
import '../services/db_connector.dart';

class DataBaseHelper {
  void queryAction(querys) async {
    final db = await DataBaseConnector.instance.database;
    for (var i = 0; i < querys.length; i++) {
      await db.execute(querys[i]);
    }
  }

  static void initTables() {
    var querys = [
      FormModel.createTableQuery,
      FormWidget.createTableQuery,
      RadioOption.createTableQuery,
      Entry.createTableQuery,
      EntryValue.createTableQuery
    ];
    DataBaseHelper().queryAction(querys);
  }

  static void dropTables() {
    var querys = [
      FormModel.dropTableQuery,
      FormWidget.dropTableQuery,
      RadioOption.dropTableQuery,
      Entry.dropTableQuery,
      EntryValue.dropTableQuery
    ];
    DataBaseHelper().queryAction(querys);
  }
}
