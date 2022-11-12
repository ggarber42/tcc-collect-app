import 'package:flutter/material.dart';

import '../../dao/form_model_dao.dart';
import '../../dao/form_widget_dao.dart';
import '../../dao/radio_option_dao.dart';
import '../../models/form_model.dart';
import '../../models/form_widget.dart';
import '../../models/radio_option.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../utils/helper.dart';

class ViewModelScreen extends StatefulWidget {
  final Map<String, dynamic> modelData;
  ViewModelScreen(this.modelData);

  @override
  State<ViewModelScreen> createState() => _ViewModelScreenState();
}

class _ViewModelScreenState extends State<ViewModelScreen> {
  final modelFormDao = FormModelDAO();
  final widgetDao = FormWidgetDAO();
  final radioDao = RadioOptionDAO();

  _getIcon(String type) {
    if (type == 'img') {
      return Icon(Icons.camera);
    }
      return Icon(Icons.text_fields);
  }

  _cloneModel() async {
    final modelForm = FormModel(
      name: widget.modelData['name'],
    );
    final modelId = await modelFormDao.add(modelForm);
    for (var field in widget.modelData['fields']) {
      final widgetId = await widgetDao.add(
        FormWidget.withModelId(
          field['name'],
          field['type'],
          modelId,
        ),
      );
      if (field['type'] == 'radio') {
        for (var option in field['options']) {
          await radioDao.add(
            RadioOption.withForeingKey(option, widgetId),
          );
        }
      }
    }
    await Helper.showSnack(context, 'Modelo criado');
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MainBar(
        windowTitle: widget.modelData['name'],
      ),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: screenHeight * 0.75),
            child: ListView.builder(
              itemCount: widget.modelData['fields'].length,
              itemBuilder: ((context, index) {
                return Card(
                    child: ListTile(
                  leading: _getIcon(widget.modelData['fields'][index]['type']),
                  title: Text(
                    widget.modelData['fields'][index]['name'],
                  ),
                ));
              }),
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: BottomButton('Clonar', _cloneModel),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
