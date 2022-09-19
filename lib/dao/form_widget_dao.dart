import 'package:collect_app/dao/radio_option_dao.dart';
import 'package:collect_app/models/radio_option.dart';

import '../interfaces/dao_interface.dart';
import '../models/form_widget.dart';
import '../services/db_connector.dart';

class FormWidgetDAO implements DAO<FormWidget> {
  @override
  Future<void> add(FormWidget formWidget) async {
    final db = await DataBaseConnector.instance.database;
    final int widgetId = await db.insert(
      '${FormWidget.tableName}',
      formWidget.getData(),
    );

    if (formWidget.getType == 'radio') {
      var optionList = formWidget.getOptionList();
      final radioName = RadioOption.tableColumns['name'];
      for (var i = 0; i < optionList.length; i++) {
        RadioOptionDAO radioDao = RadioOptionDAO();
        radioDao.add(RadioOption.withForeingKey(
          optionList[i][radioName],
          widgetId,
        ));
      }
    }
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<FormWidget>> readAll(int? id) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<int> update(FormWidget t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
