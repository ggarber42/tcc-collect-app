import 'package:flutter/material.dart';

abstract class DummyField {
  var dialog;
  var _widgetIcon;
  String? _name;
  String? _type;
  String? _query;
  Widget getWidgetBody();
  init(BuildContext context);
  String getQuery();
}
