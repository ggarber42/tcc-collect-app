import 'package:flutter/material.dart';

import '../../models/entry.dart';
import '../../screens/entries/entry_review.dart';
import '../../utils/arguments.dart';
import '../../utils/constants.dart';
import '../dialog_widgets/delete_model_dialog.dart';

class EntryTile extends StatefulWidget {
  final Entry entry;
  final Function deleteEntry;

  EntryTile(this.entry, this.deleteEntry);

  @override
  State<EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends State<EntryTile> {
  var _tapPosition;

  _getTapPosition(details) {
    setState(() {
      _tapPosition = details.globalPosition;
    });
  }

  _goToCreateEntriesScreen() {
    Navigator.pushNamed(
      context,
      EntryReviewScreen.routeName,
      arguments: EntryArguments(widget.entry.getId),
    );
  }

  _showContextMenu() async {
    final dx = _tapPosition.dx;
    final dy = _tapPosition.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, 0, 0),
      items: EntrielTileMenuOptions,
      elevation: 8.0,
    );
    return result;
  }

  _deleteEntry() async {
    final confirm = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DeleteModelDialog(
            widget.entry.entryId as int,
            'Deseja deletar a entrada?',
          );
        }) as bool;
    if (!confirm) {
      return;
    }
    widget.deleteEntry(widget.entry.entryId);
  }

  void _openMenu() async {
    final selectedOption = await _showContextMenu();
    switch (selectedOption) {
      case 'open':
        _goToCreateEntriesScreen();
        break;
      case 'edit':
        break;
      case 'delete':
        _deleteEntry();
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
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.adjust_sharp),
              title: Text(widget.entry.getName),
              trailing: Icon(Icons.more_vert),
              onLongPress: () => _openMenu(),
              onTap: () => _goToCreateEntriesScreen(),
            ),
          ],
        )),
      ),
    );
  }
}
