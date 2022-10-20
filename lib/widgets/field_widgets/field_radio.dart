import 'package:collect_app/models/radio_option.dart';
import 'package:collect_app/widgets/base_widgets/field_title.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/radio_item.dart';
import '../../interfaces/field_interface.dart';

class FieldRadio extends StatefulWidget implements Field {
  final int widgetId;
  final String name;
  final List<dynamic> options;
  final TextEditingController controller;

  FieldRadio(this.widgetId, this.name, this.options, this.controller);

  @override
  State<FieldRadio> createState() => _FieldRadioState();

  @override
  Map<String, dynamic> getInputValue() {
    final optionNumber = int.parse(controller.value.text);
    return {
      'widgetId': widgetId,
      'name': name,
      'type': 'input',
      'value': options[optionNumber][RadioOption.tableColumns['name']],
    };
  }
}

class _FieldRadioState extends State<FieldRadio> {
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.text = 0.toString();
  }

  updateSelected(value) {
    setState(() {
      selectedValue = value;
      widget.controller.text = value.toString();
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
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options.length,
              itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 1.5),
                child: RadioItem(
                  index,
                  selectedValue,
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
