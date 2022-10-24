import 'package:collect_app/widgets/custom_widgets/field_input.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:collect_app/widgets/custom_widgets/field_card.dart';
import 'package:collect_app/widgets/base_widgets/field_title.dart';
import '../../utils/helper.dart';

class FieldGPS extends StatelessWidget{
  final int widgetId;
  final String name;
  final TextEditingController controller;

  FieldGPS(this.widgetId, this.name, this.controller);


  Map<String, dynamic> getInputValue() {
    return {
      'widgetId': widgetId,
      'name': name,
      'type': 'input',
      'value': controller.value.text,
    };
  }

  _getLocation(context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    Helper.showProgressDialog(context);
    final locationData = await location.getLocation();
    var textValue = '';
    textValue += 'lat: ${Helper.roundNumber(locationData.latitude)} ';
    textValue += 'long: ${Helper.roundNumber(locationData.longitude)} ';
    textValue += 'alt: ${Helper.roundNumber(locationData.altitude)}';
    controller.text = textValue;
  }

  @override
  Widget build(BuildContext context) {
    return FieldCard(children: [
      FieldTitle(name),
      FieldInput(
        controller: controller,
        iconData: Icons.gps_fixed,
        readOnly: true,
      ),
      ElevatedButton(
        onPressed: () => _getLocation(context),
        child: Text('Buscar localização'),
      )
    ]);
  }
}
