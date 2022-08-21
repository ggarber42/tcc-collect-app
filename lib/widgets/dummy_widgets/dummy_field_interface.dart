import 'package:flutter/material.dart';

abstract class DummyField{
  var dialog;
  var _widgetIcon;
  late String _name;
  Widget getWidgetBody();
  init(BuildContext context);
}