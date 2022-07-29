import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../base_widgets/form_input.dart';

class NewFieldDialog extends StatefulWidget {


  @override
  _NewFieldDialogState createState() => _NewFieldDialogState();
}

class _NewFieldDialogState extends State<NewFieldDialog> {
  var selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo campo'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            FormInput(placeHolder: 'Nome do campo'),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(194, 194, 194, .5)),
              padding: EdgeInsets.all(5),
              child: DropdownButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                hint: Text('Selecione um tipo'),
                value: selectedValue,
                elevation: 16,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                items: DropMenuOptions,
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, selectedValue),
          child: const Text('Edit'),
        ),
      ],
    );
  }
}
