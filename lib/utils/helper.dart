import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/dialog_widgets/alert_widget_dialog.dart';

class Helper {
  static showSnack(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static String getUuid() {
    var uuid = Uuid();
    return uuid.v4();
  }

  static showWarningDialog(BuildContext context, String warning) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertWidgetFormDialog(warning);
        });
  }

  static String getTypeNameForUser(String rawType) {
    switch (rawType) {
      case 'img':
        return 'Foto';
      case 'gps':
        return 'GPS';
      case 'date':
        return 'Data';
      default:
        return 'Texto';
    }
  }

  static shouldPopDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja sair sem salvar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCELAR'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('SAIR'),
            )
          ],
        );
      },
    );
  }

  static showProgressDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Center(child: Text('Calculando')),
            content: Container(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }

  static roundNumber(number) {
    return number.toStringAsFixed(3);
  }
}
