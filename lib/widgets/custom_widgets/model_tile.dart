import 'package:collect_app/screens/entries/list_entries.dart';
import 'package:collect_app/utils/arguments.dart';
import 'package:collect_app/utils/helper.dart';
import 'package:flutter/material.dart';

import '../../models/form_model.dart';

class ModelTile extends StatefulWidget {
  final FormModel model;

  ModelTile(this.model);

  @override
  State<ModelTile> createState() => _ModelTileState();
}

class _ModelTileState extends State<ModelTile> {
  var _tapPosition;

  void _getTapPosition(details) {
    setState(() {
      _tapPosition = details.globalPosition;
    });
  }

  void _goToEntriesScreen(context) {
    Navigator.pushNamed(
      context,
      ListEntriesScreen.routeName,
      arguments: ModelArguments(
        widget.model.modelId,
        widget.model.getName,
      ),
    );
  }

  _showContextMenu(context) async {
    final dx = _tapPosition.dx;
    final dy = _tapPosition.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, 0, 0),
      items: [
        PopupMenuItem<String>(child: const Text('Abrir'), value: 'open'),
        PopupMenuItem<String>(child: const Text('Ver'), value: 'read'),
        PopupMenuItem<String>(
            child: const Text('Deletar', style: TextStyle(color: Colors.red)),
            value: 'delete'),
      ],
      elevation: 8.0,
    );
    return result;
  }

  void _openMenu(context) async {
    final selectedOption = await _showContextMenu(context);
    switch (selectedOption) {
      case 'open':
        _goToEntriesScreen(context);
        break;
      case 'read':
        print('oi');
        break;
      case 'delete':
        print('delete');
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
          leading: Icon(Icons.article_sharp),
          title: Text(widget.model.getName),
          trailing: Icon(Icons.more_vert),
          onLongPress: () => _openMenu(context),
          onTap: () => _goToEntriesScreen(context),
        ),
      ),
    );
  }
}
