import 'package:flutter/material.dart';

abstract class Dummy {
  var dialog;
  get getType;
  Widget getWidgetBody();
  init(BuildContext context);
}
