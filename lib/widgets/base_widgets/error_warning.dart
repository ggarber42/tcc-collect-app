import 'package:flutter/material.dart';

class ErrorWarning extends StatelessWidget {
  const ErrorWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Algo deu errado :(',
      style: TextStyle(fontSize: 25),
    ));
  }
}
