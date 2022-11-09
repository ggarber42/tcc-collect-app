import 'package:collect_app/screens/model_form/view_model.dart';
import 'package:collect_app/widgets/custom_widgets/main_bar.dart';
import 'package:flutter/material.dart';

import '../../facades/firestore.dart';
class ListOnlineModelsScreen extends StatefulWidget {
  @override
  State<ListOnlineModelsScreen> createState() => _ListOnlineModelsScreenState();
}

class _ListOnlineModelsScreenState extends State<ListOnlineModelsScreen> {
  final fireFacade = FirestoreFacade();

  Widget titleTile(obj) {
    return Card(child:
      ListTile(
        leading: Icon(Icons.note_alt_rounded),
        title: Text(obj['name']),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ViewModelScreen(obj),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(
        hasBackButton: true,
      ),
      body: FutureBuilder(
        future: fireFacade.getModels(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<dynamic>;
            return Scrollbar(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) => titleTile(data[index]),
              ),
            );
          }
          return Center(
            child: Text('Algo deu errado :(\nTente novamente mais tarde!'),
          );
        },
      ),
    );
  }
}
