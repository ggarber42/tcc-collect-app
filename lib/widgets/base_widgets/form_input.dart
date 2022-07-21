import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String placeHolder;

  FormInput({this.placeHolder = ''});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: placeHolder,
      ),
    );
  }
}
