import 'package:flutter/foundation.dart';

import '../dao/form_model_dao.dart';
import '../models/form_model.dart';

class FormModels with ChangeNotifier {
  List<FormModel> _formModels = [];

  _fetchModels() async {
    FormModelDAO modelDao = FormModelDAO();
    _formModels = [...await modelDao.readAll(null)];
  }

  Future<List<FormModel>> get getModels async {
    await _fetchModels();
    return [..._formModels];
  }

  updateModels() async {
    await _fetchModels();
    notifyListeners();
  }
}
