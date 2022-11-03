import 'package:collect_app/widgets/custom_widgets/main_bar.dart';
import 'package:flutter/material.dart';

import '../../dao/form_model_dao.dart';
import '../../dao/form_widget_dao.dart';
import '../../dao/radio_option_dao.dart';
import '../../facades/firestore.dart';
import '../../models/form_model.dart';
import '../../models/form_widget.dart';
import '../../models/radio_option.dart';
import '../../utils/helper.dart';
import '../../widgets/custom_widgets/field_card.dart';
import '../../widgets/dialog_widgets/confirmation_dialog.dart';

class ListOnlineModelsScreen extends StatefulWidget {
  @override
  State<ListOnlineModelsScreen> createState() => _ListOnlineModelsScreenState();
}

class _ListOnlineModelsScreenState extends State<ListOnlineModelsScreen> {
  final fireFacade = FirestoreFacade();
  final modelFormDao = FormModelDAO();
  final widgetDao = FormWidgetDAO();
  final radioDao = RadioOptionDAO();

  Widget titleTile(obj) {
    return FieldCard(children: [
      ListTile(
        leading: Icon(Icons.note_alt_rounded),
        title: Text(obj['name']),
        trailing: Icon(Icons.more_vert),
        onTap: () async {
          final res = await showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return ConfirmationDialog(
                  'Deseja criar esse modelo?',
                );
              });
          print(res);
          if (res == null) {
            return;
          }
          if (!res) {
            return;
          }
          print(obj);
          final modelForm = FormModel(
            name: obj['name'],
          );
          final modelId = await modelFormDao.add(modelForm);
          for (var field in obj['fields']) {
            final widgetId = await widgetDao.add(
              FormWidget.withModelId(
                field['name'],
                field['type'],
                modelId,
              ),
            );
            if (field['type'] == 'radio') {
              for (var option in field['options']) {
                await radioDao
                    .add(RadioOption.withForeingKey(option, widgetId));
              }
            }
          }
          await Helper.showSnack(context, 'Modelo criado');
          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        hasBackButton: true,
      ),
      body: FutureBuilder(
        future: fireFacade.getModels(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<dynamic>;
            return Scrollbar(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) => titleTile(data[index]),
              ),
            );
          }
          return Center(
            child: Text('Algo deu errado :(\nTente novamente mais tarde!'),
          );
        },
      ),
    );
  }
}
