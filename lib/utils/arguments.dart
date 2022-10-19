import 'package:flutter/cupertino.dart';

import '../models/entry_image.dart';
import '../models/entry_value.dart';

class ModelArguments {
  final int modelId;
  final String modelName;

  ModelArguments(this.modelId, this.modelName);
}

class EntryResultsArguments {
  final int entryId;

  EntryResultsArguments(this.entryId);
}

class EntryValuesArguments {
  final List<EntryValue> values;
  final VoidCallback shareValues;

  EntryValuesArguments(this.values, this.shareValues);
}

class EntryImageArguments {
  final EntryImage image;
  final VoidCallback shareValues;

  EntryImageArguments(this.image, this.shareValues);
}
