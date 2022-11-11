import 'package:flutter/material.dart';

import '../../screens/auth/auth_check.dart';
import '../../screens/backup/list_backup_entries_values.dart';
import '../../screens/model_form/list_form_model.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Opções'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.ballot_rounded),
            title: Text('Modelos'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ListFormModelsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock_rounded),
            title: Text('Autenticação'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AuthCheckScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.backup),
            title: Text('Backups'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ListBackupValuesScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
