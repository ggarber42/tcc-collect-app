import 'package:flutter/material.dart';

class ButtonLoading extends StatelessWidget {
  final Color color;
  ButtonLoading({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
