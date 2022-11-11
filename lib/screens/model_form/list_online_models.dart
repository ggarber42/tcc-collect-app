import 'package:collect_app/screens/model_form/view_model.dart';
import '../../widgets/base_widgets/error_warning.dart';
import 'package:collect_app/widgets/custom_widgets/main_bar.dart';
import '../../widgets/custom_widgets/main_bottom.dart';
import 'package:flutter/material.dart';

import '../../facades/firestore.dart';

class ListOnlineModelsScreen extends StatefulWidget {
  @override
  State<ListOnlineModelsScreen> createState() => _ListOnlineModelsScreenState();
}

class _ListOnlineModelsScreenState extends State<ListOnlineModelsScreen> {
  final fireFacade = FirestoreFacade();

  Widget titleTile(obj) {
    return Card(
      child: ListTile(
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
      bottomNavigationBar: MainBottom(currentIndex: 0),
      body: FutureBuilder(
        future: fireFacade.getModels(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List<dynamic>;
            if(data.isEmpty){
              return Center(
                  child: Text(
                    'Não há modelos cadastrados!',
                    style: TextStyle(fontSize: 22),
                  ),
                );
            }
            return Scrollbar(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) => titleTile(data[index]),
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorWarning();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
