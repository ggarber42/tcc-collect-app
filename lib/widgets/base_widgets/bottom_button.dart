import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String name;
  final VoidCallback clickHandler;

  BottomButton(this.name, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(name),
      onPressed: clickHandler,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.primary,
        textStyle: TextStyle(fontSize: 20),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap
      ),
    );
  }
}
