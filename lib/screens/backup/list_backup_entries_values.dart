import 'package:collect_app/screens/backup/list_image_files.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/arguments.dart';
import '../auth/login.dart';
import '../../facades/firestore.dart';
import '../../providers/auth_firebase.dart';
import '../../widgets/custom_widgets/main_bottom.dart';
import '../../widgets/custom_widgets/main_drawer.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../screens/backup/list_filed_entires.dart';

class ListBackupValuesScreen extends StatefulWidget {
  static const routeName = '/list-backup';
  const ListBackupValuesScreen({Key? key}) : super(key: key);

  @override
  State<ListBackupValuesScreen> createState() => _ListBackupValuesScreenState();
}

class _ListBackupValuesScreenState extends State<ListBackupValuesScreen> {
  final fireFacade = FirestoreFacade();

  Widget _notAuthWarning() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Você não está logado',
            style: TextStyle(fontSize: 25),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Text('Faça o login aqui'),
          )
        ],
      ),
    );
  }

  Widget _listTiles(String userId) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.9),
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.check_box),
              title: Text('Resultados campos'),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ListFieldEntriesScreen.routeName,
                  arguments: ListFieldEntriesArguments(userId),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check_box),
              title: Text('Imagens'),
              trailing: Icon(Icons.more_vert),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ListImageFielsScreen.routeName,
                  arguments: ListImageFilesArguments(userId),
                );
              },
            ),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.getUserId();
    return Scaffold(
      appBar: MainBar(),
      drawer: MainDrawer(),
      body: (userId == null) ? _notAuthWarning() : _listTiles(userId),
      bottomNavigationBar: MainBottom(currentIndex: 2),
    );
  }
}
