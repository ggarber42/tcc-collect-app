import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/entry_image.dart';
import '../../screens/entries/entry_result_image.dart';
import '../../utils/arguments.dart';
import '../../utils/constants.dart';

class ImageResultTile extends StatefulWidget {
  final EntryImage image;

  ImageResultTile(this.image);

  @override
  State<ImageResultTile> createState() => _ImageResultTileState();
}

class _ImageResultTileState extends State<ImageResultTile> {
    var _tapPosition;

    shareValues() async {
    Image currentImg = widget.image.getImage;
    MemoryImage memory = currentImg.image as MemoryImage;
    final list = memory.bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file =
        await File('${tempDir.path}/${widget.image.getName}.jpg').create();
    file.writeAsBytesSync(list);
    Share.shareFiles([file.path]);
  }

  _getTapPosition(details) {
    setState((() => _tapPosition = details.globalPosition));
  }

  _goToResultsScreen() {
    Navigator.pushNamed(
      context,
      EntryResultImageScreen.routeName,
      arguments: EntryImageArguments(widget.image, shareValues),
    );
  }

  _showContextMenu() async {
    final dx = _tapPosition.dx;
    final dy = _tapPosition.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, 0, 0),
      items: ResultTileValueOptions,
      elevation: 8.0,
    );
    return result;
  }

  void _openMenu() async {
    final selectedOption = await _showContextMenu();
    switch (selectedOption) {
      case 'open':
        _goToResultsScreen();
        break;
      case 'share':
        shareValues();
        break;
      default:
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _getTapPosition(details),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.image),
          title: Text(widget.image.getName),
          trailing: Icon(Icons.more_vert),
          onTap: _goToResultsScreen,
          onLongPress: _openMenu,
        ),
      ),
    );
  }
}
