import 'package:collect_app/models/radio_option.dart';

import '../interfaces/dao_interface.dart';
import '../services/db_connector.dart';

class RadioOptionDAO implements DAO<RadioOption>{
  @override
  Future<void> add(RadioOption radio) async {
    final db = await DataBaseConnector.instance.database;
    await db.insert(RadioOption.tableName, radio.getData());
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<RadioOption>> readAll(int? id) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<int> update(RadioOption t) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}