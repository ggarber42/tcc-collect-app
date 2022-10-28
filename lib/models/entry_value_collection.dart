import 'package:collect_app/models/entry_value.dart';

class EntryValueCollection {
  final String entryName;
  final List<EntryValue> values;
  String? docId;

  EntryValueCollection({required this.entryName, required this.values});

  EntryValueCollection.fromFireBase({
    required this.entryName,
    required this.values,
    this.docId,
  });

  get getName => entryName;
  get getId => docId;
  get getValues => values;

  Map<String, dynamic> toJson() => {
        'name': entryName,
        'values': values.map((value) => value.toMap()).toList()
      };
}
