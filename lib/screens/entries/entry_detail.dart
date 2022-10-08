import 'package:collect_app/widgets/custom_widgets/input_tile.dart';
import 'package:flutter/material.dart';

import '../../dao/entry_dao.dart';
import '../../models/entry.dart';
import '../../models/entry_image.dart';
import '../../models/entry_value.dart';
import '../../services/db_connector.dart';
import '../../screens/entries/entry_inputs.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/custom_widgets/image_tile.dart';
import '../../utils/helper.dart';
import '../../utils/queries.dart';

class EntryDetailScreen extends StatefulWidget {
  final int modelId;
  final String entryName;

  EntryDetailScreen(this.modelId, this.entryName);

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  var entryDAO = EntryDAO();
  var _values = {};
  var _requiredKeys = [];

  addValue(newValues) {
    for (var i = 0; i < newValues.length; i++) {
      if (_values.containsKey(newValues[i]['widgetId'])) {
        _values.update(
          newValues[i]['widgetId'],
          (value) => {
            'name': newValues[i]['name'],
            'type': newValues[i]['type'],
            'value': newValues[i]['value'],
          },
        );
      } else {
        _values.putIfAbsent(
            newValues[i]['widgetId'],
            () => {
                  'name': newValues[i]['name'],
                  'type': newValues[i]['type'],
                  'value': newValues[i]['value'],
                });
      }
    }
  }

  _getFieldsFromDB() async {
    var inputFields = [];
    var imageFields = [];
    final db = await DataBaseConnector.instance.database;
    List<Map<String, Object?>> queryResult = await db.rawQuery(
      Queries.getFieldTypes(widget.modelId),
    );
    for (var i = 0; i < queryResult.length; i++) {
      _requiredKeys.add(queryResult[i]['widgetId']);

      if (queryResult[i]['type'] == 'img') {
        imageFields.add(queryResult[i]);
      } else {
        inputFields.add(queryResult[i]);
      }
    }
    return {'imgFields': imageFields, 'inputFields': inputFields};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(windowTitle: widget.entryName),
      body: Column(
        children: [
          SingleChildScrollView(
              child: FutureBuilder(
            future: _getFieldsFromDB(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as Map<String, dynamic>;
                var imgFields = data['imgFields'] as List<dynamic>;
                var inputFields = data['inputFields'] as List<dynamic>;
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: imgFields.length,
                      itemBuilder: (ctx, index) =>
                          ImageTile(imgFields[index], addValue),
                    ),
                    InputTile(inputFields, addValue),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: BottomButton(
                  'Salvar entrada',
                  () {
                    var canSubmit = true;
                    for (var i = 0; i < _requiredKeys.length; i++) {
                      if (!_values.containsKey(_requiredKeys[i])) {
                        canSubmit = false;
                      }
                    }
                    if (canSubmit) {
                      List<EntryValue> entryValues = [];
                      List<EntryImage> entryImages = [];
                      _values.values.forEach((value) {
                        if (value['type'] == 'img') {
                          entryImages.add(EntryImage.fromField(
                            value['name'],
                            value['value'],
                          ));
                        } else {
                          entryValues.add(EntryValue.fromField(
                            value['name'],
                            value['value'],
                          ));
                        }
                      });
                      entryDAO.add(
                        Entry.withValues(
                          widget.entryName,
                          widget.modelId,
                          entryValues,
                          entryImages,
                        ),
                      );
                      Helper.showSnack(context, 'Entrada salva');
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      Helper.showWarningDialog(
                        context,
                        'Há campos sem preenchimento',
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
