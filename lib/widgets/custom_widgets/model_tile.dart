import 'package:collect_app/screens/entries/list_entries.dart';
import 'package:collect_app/utils/arguments.dart';
import 'package:flutter/material.dart';

import '../../models/form_model.dart';

class ModelTile extends StatelessWidget {
  final FormModel model;

  ModelTile(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          child: Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.article_sharp),
                title: Text(model.getName),
              ),
            ],
          )),
          onTap: () => Navigator.pushNamed(
                context,
                ListEntriesScreen.routeName,
                arguments: ModelArguments(
                  model.modelId,
                  model.getName,
                ),
              )),
    );
  }
}
