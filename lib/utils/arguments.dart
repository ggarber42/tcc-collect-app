import 'package:flutter/cupertino.dart';

import '../models/entry.dart';
import '../models/entry_image.dart';
import '../models/entry_value.dart';

class ModelArguments {
  final int modelId;
  final String modelName;

  ModelArguments(this.modelId, this.modelName);
}

class EntryResultsArguments {
  final Entry entry;

  EntryResultsArguments(this.entry);
}

class EntryValuesArguments {
  final List<EntryValue> values;
  final VoidCallback shareValues;
  final VoidCallback backupEntryValues;
  final bool hasBackupValue;

  EntryValuesArguments(
    this.values,
    this.shareValues,
    this.backupEntryValues,
    this.hasBackupValue,
  );
}

class EntryImageArguments {
  final EntryImage image;
  final VoidCallback shareValues;

  EntryImageArguments(this.image, this.shareValues);
}
