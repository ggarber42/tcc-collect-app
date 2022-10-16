import 'package:collect_app/models/radio_option.dart';
import 'package:collect_app/widgets/base_widgets/field_title.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/radio_item.dart';
import '../../interfaces/field_interface.dart';
import '../../utils/extensions.dart';

class FieldRadio extends StatefulWidget implements Field {
  final int widgetId;
  final String name;
  final List<dynamic> options;
  int selectedValue = 0;

  FieldRadio(this.widgetId, this.name, this.options);

  @override
  State<FieldRadio> createState() => _FieldRadioState();

  @override
  Map<String, dynamic> getInputValue() {
    return {
      'widgetId': widgetId,
      'name': name,
      'type': 'input',
      'value': options[selectedValue][RadioOption.tableColumns['name']],
    };
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Column(children: [
            FieldTitle(widget.name),
            const SizedBox(height: 10,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 1.5),
                child: RadioItem(
                  index,
                  widget.selectedValue,
                  // widget.options[index]['optionName'],
                  widget.options[index][RadioOption.tableColumns['name']],
                  updateSelected,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
