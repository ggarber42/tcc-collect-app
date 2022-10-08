import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/dialog_widgets/alert_widget_dialog.dart';

class Helper {
  static showSnack(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ));
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
}

class StackHelper<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
