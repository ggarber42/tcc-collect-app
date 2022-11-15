import '../models/entry.dart';

class BackupModel {
  final String modelName;
  List<Entry>? entries;

  BackupModel(
    this.modelName,
    this.entries,
  );

  BackupModel.onlyName({required this.modelName, this.entries});

  get getModelName => modelName;

  set setEntries(List<Entry> newEntries) => entries = newEntries;

  get getEntries => entries;
}
