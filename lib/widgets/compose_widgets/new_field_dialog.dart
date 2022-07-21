import 'package:flutter/material.dart';

import '../base_widgets/form_input.dart';

class NewFieldDialog extends StatelessWidget {
  var selectedField;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            FormInput(placeHolder: 'Nome do campo'),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(194, 194, 194, .5)),
              child: DropdownButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                value: 'Radio Group',
                elevation: 16,
                onChanged: (value) {
                  selectedField = value;
                },
                items: <String>['Radio Group']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
       actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: (){
            print(selectedField);
          },
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
