import '../models/form_model.dart';
import '../models/form_widget.dart';

class Queries {
  static getFieldTypes(int modelId){
    var formWidgetTableName = FormWidget.tableName;
    var formWidgdetName = FormWidget.tableColumns['name'];
    var formWidgetTableId = FormWidget.tableColumns['id'];
    var formWidgetTableType = FormWidget.tableColumns['type'];
    var formModelTableName = FormModel.tableName;
    var formModelTableId = FormModel.tableColumns['id'];

    return '''
      SELECT  $formWidgetTableName.$formWidgetTableId, $formWidgetTableType, $formWidgetTableName.$formWidgdetName
      FROM $formModelTableName
      INNER JOIN $formWidgetTableName
      ON $formModelTableName.$formModelTableId = $formWidgetTableName.$formModelTableId
      WHERE $formWidgetTableName.$formModelTableId =
      $modelId;
    ''';

  }
}