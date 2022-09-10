import 'package:flutter/material.dart';

import '../custom_widgets/radio_item.dart';

class FieldRadio extends StatefulWidget {
  final String name;
  final List<dynamic> options;

  FieldRadio(this.name, this.options);

  @override
  State<FieldRadio> createState() => _FieldRadioState();
}

class _FieldRadioState extends State<FieldRadio> {
  var _selectedValue;

  updateSelected(value) {
    setState(() {
      _selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.name),
      ListView.builder(
        shrinkWrap: true,
        itemCount: widget.options.length,
        itemBuilder: (ctx, index) => Container(
          margin: EdgeInsets.symmetric(vertical: 1.5),
          child: RadioItem(
            index,
            _selectedValue,
            widget.options[index]['optionName'],
            updateSelected,
          ),
        ),
      )
    ]);
  }
}
