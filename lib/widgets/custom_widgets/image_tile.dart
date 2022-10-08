import 'package:flutter/material.dart';

import '../../screens/entries/entry_image.dart';

class ImageTile extends StatelessWidget {
  final imageWidgetData;
  final Function addValue;

  ImageTile(this.imageWidgetData, this.addValue);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      child: Card(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text(imageWidgetData['name']),
          ),
        ],
      )),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EntryImageScreen(
              imageWidgetData,
              addValue,
            ),
          )),
    ));
  }
}
