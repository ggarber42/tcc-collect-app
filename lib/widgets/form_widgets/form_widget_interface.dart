import 'package:flutter/material.dart';

abstract class FormWidget{
  Future<dynamic> showCreateDialog(BuildContext context);
  Widget getWidgetBody();
}