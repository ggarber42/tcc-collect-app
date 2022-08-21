import 'package:flutter/material.dart';

abstract class FormWidget{
  var dialog;
  Widget getWidgetBody();
  void init(BuildContext context);
}