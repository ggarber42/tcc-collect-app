import 'package:flutter/material.dart';

abstract class Dummy {
  var dialog;
  get getType;
  Widget getWidgetBody(index, function, context);
  init(BuildContext context);
}
