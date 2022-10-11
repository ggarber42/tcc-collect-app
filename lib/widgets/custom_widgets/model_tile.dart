import 'package:collect_app/screens/entries/list_entries.dart';
import 'package:collect_app/screens/model_form/edit_form_model.dart';
import 'package:collect_app/utils/arguments.dart';
import 'package:collect_app/utils/helper.dart';
import 'package:collect_app/widgets/dialog_widgets/delete_model_dialog.dart';
import 'package:flutter/material.dart';

import '../../models/form_model.dart';
import '../../utils/constants.dart';

class ModelTile extends StatefulWidget {
  final FormModel model;
  final Function deleteModel;

  ModelTile(this.model, this.deleteModel);

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

  void _goToEditScreen(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditFormModelScreen(widget.model.modelId),
        ));
  }

  _deleteModel(context) async{
    final confirm = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DeleteModelDialog(widget.model.modelId, 'Deseja deletar a modelo?');
        }) as bool;
    if (!confirm) {
      return;
    }
    widget.deleteModel(widget.model.modelId);
  }

  _showContextMenu(context) async {
    final dx = _tapPosition.dx;
    final dy = _tapPosition.dy;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, 0, 0),
      items: ModelTileMenuOptions,
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
      case 'edit':
        _goToEditScreen(context);
        break;
      case 'delete':
        _deleteModel(context);
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
