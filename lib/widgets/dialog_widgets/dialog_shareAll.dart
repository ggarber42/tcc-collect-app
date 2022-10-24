import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class DialogShareAll extends StatefulWidget {
  @override
  _DialogShareAllState createState() => _DialogShareAllState();
}

class _DialogShareAllState extends State<DialogShareAll> {
  var selectedValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('O que compartilhar'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
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
                items: DropShareOptionsAll,
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, selectedValue),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
