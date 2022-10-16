import 'package:flutter/material.dart';

import '../../utils/extensions.dart';

class FieldTitle extends StatelessWidget {
  final String title;

  FieldTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Text(
          title.capitalize(),
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
