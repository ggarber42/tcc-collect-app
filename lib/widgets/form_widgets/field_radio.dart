import 'package:flutter/material.dart';

import '../../interfaces/field_interface.dart';
import '../custom_widgets/radio_item.dart';

class FieldRadio extends StatefulWidget implements Field {
  final String name;
  final List<dynamic> options;
  int selectedValue = 0;

  FieldRadio(this.name, this.options);

  @override
  State<FieldRadio> createState() => _FieldRadioState();

  @override
  String getInputValue() {
    return options[selectedValue]['optionName'];
  }
}

class _FieldRadioState extends State<FieldRadio> {
  updateSelected(value) {
    setState(() {
      widget.selectedValue = value;
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
            widget.selectedValue,
            widget.options[index]['optionName'],
            updateSelected,
          ),
        ),
      )
    ]);
  }
}
