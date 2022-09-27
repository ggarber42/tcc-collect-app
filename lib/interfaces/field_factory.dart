import 'package:flutter/material.dart';

abstract class FieldFactory{
  Future<Widget> makeWidget(int widgetId, TextEditingController controller);
}