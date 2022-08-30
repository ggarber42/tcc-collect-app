import 'package:flutter/material.dart';

import '../../models/model_form.dart';

class ModelTile extends StatelessWidget {
  final ModelForm model;
  final Function fetchModels;

  ModelTile(this.model, this.fetchModels);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.article_sharp),
            title: Text(model.modelName),
          ),
        ],
      )),
    );
  }
}
