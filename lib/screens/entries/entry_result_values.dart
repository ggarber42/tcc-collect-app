import 'package:flutter/material.dart';

import '../../models/entry_value.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class EntryValuesResultScreen extends StatelessWidget {
  static const routeName = '/entry_results_input';
  final List<EntryValue> values;
  final VoidCallback shareValues;
  final VoidCallback backupEntryValues;
  final bool hasBackupValue;

  EntryValuesResultScreen(
    this.values,
    this.shareValues,
    this.backupEntryValues,
    this.hasBackupValue,
  );

  Widget _viewResultTile(value) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value.getName,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(value.getValue),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Resultados',
        hasBackButton: true,
        hasShareAction: true,
        hasBackup: true,
        shareFunction: shareValues,
        backupFunction: backupEntryValues,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.95,
          ),
          child: Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (ctx, i) => _viewResultTile(values[i]),
            ),
          ),
        ),
      ),
    );
  }
}
