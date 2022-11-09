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
  final VoidCallback updateState;

  EntryResultsArguments(this.entry, this.updateState);
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
  final VoidCallback backupImage;

  EntryImageArguments(this.image, this.shareValues, this.backupImage);
}

class ListFieldEntriesArguments{
  final String userId;

  ListFieldEntriesArguments(this.userId);
}

class ListImageFilesArguments{
  final String userId;

  ListImageFilesArguments(this.userId);
}
