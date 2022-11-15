import 'package:collect_app/facades/firestore.dart';
import 'package:flutter/material.dart';

import '../../models/entry.dart';
import '../../screens/backup/list_field_values.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';

class BackupEntryTile extends StatefulWidget {
  final Entry entry;
  final String userId;

  BackupEntryTile(this.entry, this.userId);

  @override
  State<BackupEntryTile> createState() => _BackupEntryTileState();
}

class _BackupEntryTileState extends State<BackupEntryTile> {
  final fireFacade = FirestoreFacade();
  var _tapPosition;

  deleteCollection() async {
    Helper.showSnack(context, 'Documento deletado');
    await fireFacade.deleteBackup(widget.userId, widget.entry.getDocId);
    // await entryDao.deleteDocValuesId(widget.docId);
  }

  _getTapPosition(details) {
    setState(() {
      _tapPosition = details.globalPosition;
    });
  }

  _goToDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => ListFieldValuesScreen(widget.entry, deleteCollection)),
      ),
    );
  }

  _showContextMenu() async {
    final dx = _tapPosition.dx;
    final dy = _tapPosition.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, 0, 0),
      items: CollectionTileMenuOptions,
      elevation: 8.0,
    );
    return result;
  }

  void _openMenu() async {
    final selectedOption = await _showContextMenu();
    switch (selectedOption) {
      case 'open':
        _goToDetailsScreen();
        break;
      case 'delete':
        deleteCollection();
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
          title: Text(widget.entry.getName),
          trailing: Icon(Icons.more_vert),
          onTap: _goToDetailsScreen,
          onLongPress: _openMenu,
        ),
      ),
    );
  }
}
