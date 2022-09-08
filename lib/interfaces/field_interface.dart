import 'package:flutter/material.dart';

abstract class Field {
  Future init(int widgetId);
  Widget getWidgetBody();
}
