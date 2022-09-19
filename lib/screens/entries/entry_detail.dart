import 'package:collect_app/models/entry_value.dart';
import 'package:collect_app/widgets/base_widgets/main_bar.dart';
import 'package:flutter/material.dart';

import '../../dao/entry_value_dao.dart';

class EntryDetailScreen extends StatefulWidget {
  final int entryId;
  static const routeName = '/entry_detail';

  EntryDetailScreen(this.entryId);

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  _fetchValues() async {
    EntryValueDAO entryValueDao = EntryValueDAO();
    var values = [...await entryValueDao.readAll(widget.entryId)];
    return values;
  }

  @override
  void initState() {
    super.initState();
    _fetchValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: FutureBuilder(
          future: _fetchValues(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var values = snapshot.data as List<EntryValue>;
              return ListView.builder(
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
      ),
    );
  }
}
