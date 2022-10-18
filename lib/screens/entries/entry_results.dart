import 'package:flutter/material.dart';

import '../../dao/entry_image_dao.dart';
import '../../dao/entry_value_dao.dart';
import '../../models/entry_image.dart';
import '../../models/entry_value.dart';
import '../../widgets/custom_widgets/image_result_tile.dart';
import '../../widgets/custom_widgets/result_tile.dart';
import '../../widgets/custom_widgets/main_bar.dart';

class EntryResultScreen extends StatefulWidget {
  final int entryId;
  static const routeName = '/entry_results';

  EntryResultScreen(this.entryId);

  @override
  State<EntryResultScreen> createState() => _EntrysResultScreenState();
}

class _EntrysResultScreenState extends State<EntryResultScreen> {
  final entryValueDao = EntryValueDAO();
  final imageDao = EntryImageDAO();

  _fetchValues() async {
    return [...await entryValueDao.readAll(widget.entryId)];
  }

  _fetchImages() async {
    return [...await imageDao.readAll(widget.entryId)];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Resultados da entrada',
        hasBackButton: true,
        clickHandler: () => Navigator.of(context).pop(),
      ),
      body: Container(
        constraints: BoxConstraints(maxHeight: screenHeight * 0.9),
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder(
              future: _fetchValues(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var values = snapshot.data as List<EntryValue>;
                  return ResultTile(values);
                }
                return SizedBox.shrink();
              },
            ),
            FutureBuilder(
              future: _fetchImages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var entryImages = snapshot.data as List<EntryImage>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: entryImages.length,
                    itemBuilder: (ctx, i) => ImageResultTile(entryImages[i]),
                  );
                }
                return Center(child: Text('Nao existem entradas'));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
