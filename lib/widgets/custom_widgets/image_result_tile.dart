import 'package:collect_app/facades/share.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../facades/firestore.dart';
import '../../models/entry_image.dart';
import '../../providers/auth_firebase.dart';
import '../../screens/entries/entry_result_image.dart';
import '../../utils/arguments.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';

class ImageResultTile extends StatefulWidget {
  final EntryImage image;

  ImageResultTile(this.image);

  @override
  State<ImageResultTile> createState() => _ImageResultTileState();
}

class _ImageResultTileState extends State<ImageResultTile> {
  final FirestoreFacade fireFacade = FirestoreFacade();
  final shareFacade = ShareFacade();

  var _tapPosition;

  showUploadWarning() {
    Helper.showSnack(context, 'Upload feito!');
  }

  showFeedback() {
    Helper.showUploadDialog(context);
  }

  backupImage() {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.getUserId();
    if (userId == null) {
      return Helper.showWarningDialog(context, 'Você precisa se autenticar!');
    }
    fireFacade.uploadImage(
      widget.image,
      userId,
      showFeedback,
      showUploadWarning,
    );
  }

  shareValues() async {
    shareFacade.shareImage(widget.image);
  }

  _getTapPosition(details) {
    setState((() => _tapPosition = details.globalPosition));
  }

  _goToResultsScreen() {
    Navigator.pushNamed(
      context,
      EntryResultImageScreen.routeName,
      arguments: EntryImageArguments(widget.image, shareValues, backupImage),
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
        backupImage();
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
