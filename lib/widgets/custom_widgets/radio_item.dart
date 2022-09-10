import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  final int radioValue;
  final int formValue;
  final String name;
  final Function changeHandler;

  RadioItem(
    this.radioValue,
    this.formValue,
    this.name,
    this.changeHandler,
  );

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
        value: radioValue,
        groupValue: formValue,
        onChanged: (dynamic radioValue) => changeHandler(radioValue),
      ),
    );
  }
}
