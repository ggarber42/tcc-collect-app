import 'package:flutter/material.dart';

abstract class FormWidget{
  var dialog;
  String? _name;
  Widget getWidgetBody();
  init(BuildContext context);
}