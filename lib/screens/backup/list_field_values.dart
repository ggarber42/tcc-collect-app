import 'package:flutter/material.dart';

import '../../models/entry.dart';
import '../../models/entry_value.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class ListFieldValuesScreen extends StatelessWidget {
  final Entry entry;
  final VoidCallback deleteFunction;

  ListFieldValuesScreen(this.entry, this.deleteFunction);

  Widget _fieldTile(EntryValue value) {
    return Column(
      children: [
        ListTile(
          title: Text(value.getName),
          subtitle: Text(value.getValue),
        ),
        Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final values = entry.getValues;
    return Scaffold(
      appBar: MainBar(
        hasDeleteAction: true,
        deleteFunction: deleteFunction,
      ),
      body: Container(
          height: size.height * 0.8,
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: ((context, index) => _fieldTile(values[index])),
            ),
          )),
    );
  }
}
