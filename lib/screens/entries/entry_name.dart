import 'package:flutter/material.dart';

import 'entry_inputs.dart';
import '../../services/db_connector.dart';
import '../../utils/helper.dart';
import '../../utils/queries.dart';
import '../../widgets/base_widgets/main_bar.dart';
import '../../widgets/base_widgets/name_input.dart';

class EntryNameScreen extends StatefulWidget {
  final int modelId;

  EntryNameScreen(this.modelId);

  @override
  State<EntryNameScreen> createState() => _EntryNameScreenState();
}

class _EntryNameScreenState extends State<EntryNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var inputFields = [];
  var imageFields = StackHelper();

  void _getFieldsFromDB() async {
    final db = await DataBaseConnector.instance.database;
    List<Map<String, Object?>> queryResult = await db.rawQuery(
      Queries.getFieldTypes(widget.modelId),
    );
    for (var i = 0; i < queryResult.length; i++) {
      if (queryResult[i]['type'] == 'img') {
        imageFields.push(queryResult[i]);
      } else {
        inputFields.add(queryResult[i]);
      }
    }
  }

  @override
  void initState() {
    _getFieldsFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: _formKey,
              child: NameInput(
                'Nome da entrada*',
                _nameController,
              ),
            ),
            ElevatedButton(
              child: Text('Avançar'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntryInputsScreen(
                        widget.modelId,
                        _nameController.value.text,
                        inputFields,
                        imageFields,
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}
