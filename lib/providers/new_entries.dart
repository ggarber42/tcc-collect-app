import 'package:flutter/foundation.dart';

class NewEntries with ChangeNotifier {
  List<String> _newValues = [];

  List<String> get orders {
    return [..._newValues];
  }

  void addValue(String value) {
    _newValues.add(value);
    notifyListeners();
  }
}
