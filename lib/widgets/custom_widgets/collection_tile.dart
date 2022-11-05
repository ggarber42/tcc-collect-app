import 'package:collect_app/dao/entry_dao.dart';
import 'package:collect_app/facades/firestore.dart';
import 'package:flutter/material.dart';

import '../../models/entry_value_collection.dart';
import '../../screens/backup/backup_value_detail.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';

class CollectionTile extends StatefulWidget {
  final int index;
  final String docId;
  final String userId;
  final EntryValueCollection collection;

  CollectionTile(this.index, this.docId, this.userId, this.collection);

  @override
  State<CollectionTile> createState() => _CollectionTileState();
}

class _CollectionTileState extends State<CollectionTile> {
  final fireFacade = FirestoreFacade();
  final EntryDAO entryDao = EntryDAO();
  var _tapPosition;

  deleteCollection() async {
    Helper.showSnack(context, 'Documento deletado');
    await fireFacade.deleteBackup(widget.userId, widget.docId);
    await entryDao.deleteDocValuesId(widget.docId);
  }

  _getTapPosition(details) {
    setState(() {
      _tapPosition = details.globalPosition;
    });
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

  _goToDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BackupValueDetailScreen(
          widget.collection.getValues,
          deleteCollection,
        ),
      ),
    );
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
    return Container(
      child: GestureDetector(
        onTapDown: (details) => _getTapPosition(details),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text(widget.collection.getName),
                trailing: Icon(Icons.more_vert),
                onLongPress: () => _openMenu(),
                onTap: _goToDetailsScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
