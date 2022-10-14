import 'package:collect_app/models/entry_image.dart';
import 'package:collect_app/models/entry_value.dart';
import 'package:collect_app/widgets/custom_widgets/main_bar.dart';
import 'package:flutter/material.dart';

import '../../dao/entry_image_dao.dart';
import '../../dao/entry_value_dao.dart';

class EntryReviewScreen extends StatefulWidget {
  final int entryId;
  static const routeName = '/entry_detail';

  EntryReviewScreen(this.entryId);

  @override
  State<EntryReviewScreen> createState() => _EntryReviewScreenState();
}

class _EntryReviewScreenState extends State<EntryReviewScreen> {
  _fetchValues() async {
    EntryValueDAO entryValueDao = EntryValueDAO();
    var values = [...await entryValueDao.readAll(widget.entryId)];
    return values;
  }

  _fetchImages() async {
    EntryImageDAO imageDao = EntryImageDAO();
    var images = [...await imageDao.readAll(widget.entryId)];
    return images;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: _fetchValues(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var values = snapshot.data as List<EntryValue>;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: values.length,
                        itemBuilder: (ctx, i) => Row(
                          children: [
                            Text(values[i].getName),
                            Text(' : '),
                            Text(values[i].getValue),
                          ],
                        ),
                      );
                    }
                    return Center(child: Text('Nao existem entradas'));
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
                        itemBuilder: (ctx, i) => Column(
                          children: [
                            Text(entryImages[i].getName),
                            Container(
                              height: 250.0,
                              alignment: Alignment.center,
                              child: entryImages[i].getImage,
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(child: Text('Nao existem entradas'));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
