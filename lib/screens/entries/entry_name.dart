import 'package:collect_app/screens/entries/entry_detail.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/base_widgets/name_input.dart';

class EntryNameScreen extends StatelessWidget {
  final int modelId;
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final screenName = 'Nome entrada';

  EntryNameScreen(this.modelId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MainBar(
          windowTitle: screenName,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: _formKey,
              child: NameInput(
                '$screenName*',
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
                      builder: (context) => EntryDetailScreen(
                          modelId, _nameController.value.text),
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}
