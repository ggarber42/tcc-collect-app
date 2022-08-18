import 'package:flutter/material.dart';

abstract class FormWidget{
  Widget getWidgetBody();
  void init(value);
}