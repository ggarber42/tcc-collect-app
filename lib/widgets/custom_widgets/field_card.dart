import 'package:flutter/material.dart';

class FieldCard extends StatelessWidget {
  final List<Widget> children;

  FieldCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: children),
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
