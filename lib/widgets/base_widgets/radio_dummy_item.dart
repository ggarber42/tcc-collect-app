import 'package:flutter/material.dart';

class RadioDummyItem extends StatelessWidget {
  final String name;

  RadioDummyItem(this.name);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      // color: Theme.of(context).colorScheme.secondary,
       shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      child: RadioListTile(
        title: Text(name),
        value: 0,
        groupValue: null,
        onChanged: (dynamic _) {},
      ),
    );
  }
}
