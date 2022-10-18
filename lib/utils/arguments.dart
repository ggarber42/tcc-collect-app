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

  EntryValuesArguments(this.values);
}

class EntryImageArguments {
  final EntryImage image;

  EntryImageArguments(this.image);
}

