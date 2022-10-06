import 'dart:io';
import 'package:collect_app/models/entry_image.dart';
import 'package:flutter/material.dart';

import '../../dao/entry_dao.dart';
import '../../models/entry.dart';
import '../../models/entry_value.dart';
import '../../utils/helper.dart';
import '../../widgets/base_widgets/bottom_button.dart';
import '../../widgets/base_widgets/main_bar.dart';

class EntryConfirmationScreen extends StatelessWidget {
  final int modelId;
  final String entryName;
  final List<EntryValue> values;
  final List<EntryImage> images;
  final EntryDAO entryDAO = EntryDAO();

  EntryConfirmationScreen(
      this.modelId, this.entryName, this.values, this.images);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainBar(
          windowTitle: 'Confirmação',
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: images.length,
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          Text(images[index].getName),
                          Container(
                            height: 250.0,
                            alignment: Alignment.center,
                            child: Image.file(
                              File(images[index].path),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: values.length,
                      itemBuilder: (ctx, index) => Row(
                        children: [
                          Text(values[index].getName),
                          Text(' : '),
                          Text(values[index].getValue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: BottomButton('Finalizar', () {
                      entryDAO.add(
                        Entry.withValues(
                          entryName,
                          modelId,
                          values,
                          images,
                        ),
                      );
                      Helper.showSnack(context, 'Entrada salva');
                      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                    })),
              ),
            )
          ],
        ));
  }
}
