import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String name;
  final VoidCallback clickHandler;

  BottomButton(this.name, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
      elevation: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Text(name, style: TextStyle(fontSize: 20)),
      onPressed: clickHandler,
    );
  }
}
