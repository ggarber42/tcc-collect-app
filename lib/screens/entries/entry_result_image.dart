import 'package:flutter/material.dart';

import '../../models/entry_image.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class EntryResultImageScreen extends StatelessWidget {
  final EntryImage image;
  final VoidCallback shareValues;
  static const routeName = '/entry_result_image';
  
  EntryResultImageScreen(this.image, this.shareValues);

  @override
  Widget build(BuildContext context) {
    final currentHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MainBar(
        windowTitle: image.getName,
        hasShareAction: true,
        hasBackButton: true,
        shareFunction: shareValues,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, currentHeigth * 0.05, 10, 0),
        child: Card(
          child: Container(
            constraints: BoxConstraints(maxHeight: currentHeigth * 0.5),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  image.getName,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 250.0,
                  alignment: Alignment.center,
                  child: image.getImage,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}