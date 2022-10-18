import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/entry_image.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class EntryResultImageScreen extends StatelessWidget {
  final EntryImage image;
  static const routeName = '/entry_result_image';
  EntryResultImageScreen(this.image);

  shareValues() async {
    Image currentImg = image.getImage;
    MemoryImage memory = currentImg.image as MemoryImage;
    final list = memory.bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/${image.getName}.jpg').create();
    file.writeAsBytesSync(list);
    Share.shareFiles([file.path]);
  }

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
