import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';

import '../../models/entry_value.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class EntryValuesResultScreen extends StatelessWidget {
  final List<EntryValue> values;
  static const routeName = '/entry_results_input';

  EntryValuesResultScreen(this.values);

  shareValues() async {
    await SocialShare.shareOptions('kkkk');
  }

  Widget _viewResultTile(value) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(value.getName,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(value.getValue),
            ]),
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
        shareFunction: shareValues,
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
