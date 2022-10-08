import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../interfaces/field_interface.dart';

class FieldGPS extends StatelessWidget implements Field {
  final int widgetId;
  final String name;
  final TextEditingController controller;

  FieldGPS(this.widgetId, this.name, this.controller);

  @override
  Map<String, String> getInputValue() {
    return {
      'name': name,
      'type': 'input',
      'value': controller.value.text,
    };
  }

  dynamic _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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

    _locationData = await location.getLocation();
    controller.text = _locationData.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: name,
          icon: Icon(
            Icons.gps_fixed_sharp,
          )),
      textInputAction: TextInputAction.done,
      validator: (String? text) {
        if (text == null || text.isEmpty) {
          return 'Esse campo não pode ser nulo';
        }
        return null;
      },
      onTap: _getLocation,
    );
  }
}
