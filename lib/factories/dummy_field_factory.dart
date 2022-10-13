import 'package:flutter/material.dart';

import '../interfaces/dummy_interface.dart';
import '../widgets/dummy_widgets/dummy_field.dart';
import '../widgets/dummy_widgets/dummy_field_radio.dart';

class DummyFactoryField {
  IconData _getIcon(String selectedType) {
    var selectedIcon;
    switch (selectedType) {
      case 'date':
        selectedIcon = Icons.date_range;
        break;
      case 'gps':
        selectedIcon = Icons.gps_fixed_sharp;
        break;
      case 'img':
        selectedIcon = Icons.image;
        break;
      case 'radio':
        selectedIcon = Icons.radio_button_checked_outlined;
        break;
      default:
        selectedIcon = Icons.text_fields;
    }
    return selectedIcon;
  }

  Dummy _getSelectedWidget(String selectedType) {
    Dummy dummyField;
    switch (selectedType) {
      case 'date':
        dummyField = DummyField(selectedType, Icons.date_range);
        break;
      case 'radio':
        dummyField = DummyFieldRadio(Icons.radio_button_checked);
        break;
      case 'gps':
        dummyField = DummyField(selectedType, Icons.gps_fixed_sharp);
        break;
      case 'img':
        dummyField = DummyField(selectedType, Icons.image);
        break;
      default:
        dummyField = DummyField(selectedType, Icons.text_fields);
    }
    return dummyField;
  }

  Future<Dummy> createFormField(
    BuildContext context,
    String selectedType,
  ) async {
    Dummy selectedField = _getSelectedWidget(selectedType);
    await selectedField.init(context);
    return selectedField;
  }

  Dummy getFields(widgetData, options) {
    final widgetId = widgetData['widgetId'];
    final type = widgetData['type'];
    final name = widgetData['name'];
    final icon = _getIcon(type);
    if (type == 'radio') {
      var optionsName = [];
      for (var option in options) {
        optionsName.add(option['name']);
      }
      return DummyFieldRadio.fromEditScreen(icon, name, optionsName);
    }
    // return DummyField.fromEditScreen(widgetId, type, name, icon);
    return DummyField.fromEditScreen(
      widgetId: widgetId,
      type: type,
      name: name,
      widgetIcon: icon,
    );
  }
}
