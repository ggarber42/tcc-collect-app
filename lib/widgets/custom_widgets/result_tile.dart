import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../dao/backup_validation_dao.dart';
import '../../dao/entry_dao.dart';
import '../../facades/firestore.dart';
import '../../facades/share.dart';
import '../../dao/form_model_dao.dart';
import '../../providers/auth_firebase.dart';
import '../../models/backup_validation.dart';
import '../../models/entry.dart';
import '../../models/entry_value.dart';
import '../../widgets/dialog_widgets/dialog_share.dart';
import '../../screens/entries/entry_result_values.dart';
import '../../utils/arguments.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';

class ResultTile extends StatefulWidget {
  final Entry entry;
  final List<EntryValue> values;
  final VoidCallback updateState;

  ResultTile(this.entry, this.values, this.updateState);

  @override
  State<ResultTile> createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
  final fireFacade = FirestoreFacade();
  final shareFacade = ShareFacade();
  final entryDao = EntryDAO();
  final modelDao = FormModelDAO();
  final validationDao = BackupValidationDAO();
  var _tapPosition;
  var hasBackupValue = false;

  @override
  void initState() {
    final BackupValidation? backupValidation = widget.entry.getValidation;
    if (backupValidation != null) {
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      if (auth.getUserId() == backupValidation.userId) {
        hasBackupValue = true;
      }
    }
    super.initState();
  }

  _getValuesAsText() {
    var valuesAsText = '';
    widget.values.forEach((value) {
      valuesAsText += '${value.getName} ${value.getValue}\n';
    });
    return valuesAsText;
  }

  _generateCSV() {
    List<List<dynamic>> rows = [];

    for (var value in widget.values) {
      List<dynamic> row = [];
      row.add(value.getName);
      rows.add(row);
    }
    for (var value in widget.values) {
      List<dynamic> row = [];
      row.add(value.getValue);
      rows.add(row);
    }
    return ListToCsvConverter().convert(rows);
  }

  backupEntryValues() async {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.getUserId();
    if (userId == null) {
      return Helper.showWarningDialog(
        context,
        'Você precisa se autenticar!',
      );
    }
    if (hasBackupValue) {
      return Helper.showWarningDialog(
        context,
        'Este resultado já possui backup!',
      );
    }
    final modelName = await modelDao.getNameFromModel(widget.entry.getModelId);
    await fireFacade.addBackupFile(userId, widget.entry.entryId as int,
        widget.entry.getName, widget.values, modelName);
    Helper.showSnack(context, 'Backup realizado');
    widget.updateState();
    setState(() => hasBackupValue = true);
  }

  showShareDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogShare();
        });
  }

  shareValues() async {
    final selectedValue = await showShareDialog();
    if (selectedValue == null) return;
    switch (selectedValue) {
      case 'csv':
        final csv = await _generateCSV();
        shareFacade.shareCSV(csv);
        break;
      default:
        final valuesAsText = _getValuesAsText();
        Share.share(valuesAsText);
        break;
    }
  }

  _getTapPosition(details) {
    setState((() => _tapPosition = details.globalPosition));
  }

  _goToResultsScreen() {
    Navigator.pushNamed(
      context,
      EntryValuesResultScreen.routeName,
      arguments: EntryValuesArguments(
        widget.values,
        shareValues,
        backupEntryValues,
        hasBackupValue,
      ),
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
      case 'backup':
        await backupEntryValues();
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
          leading: Icon(Icons.check_box),
          title: Text('Resultados campos'),
          trailing: Icon(Icons.more_vert),
          onTap: _goToResultsScreen,
          onLongPress: _openMenu,
        ),
      ),
    );
  }
}
