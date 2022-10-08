import 'package:flutter/material.dart';

import '../../models/entry.dart';
import '../../screens/entries/entry_review.dart';
import '../../utils/arguments.dart';

class EntryTile extends StatelessWidget {
  final Entry entry;

  EntryTile(this.entry);

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
                title: Text(entry.getName),
              ),
            ],
          )),
          onTap: () => Navigator.pushNamed(
                context,
                EntryReviewScreen.routeName,
                arguments: EntryArguments(
                  entry.getId
                ),
              )),
    );
  }
}
