import 'package:flutter/material.dart';

import '../../screens/auth/auth_check.dart';
import '../../screens/backup/list_backup_entries_values.dart';
import '../../screens/model_form/list_form_model.dart';

class MainBottom extends StatefulWidget {
  final int currentIndex;

  MainBottom({this.currentIndex = 0});

  @override
  State<MainBottom> createState() => _MainBottomState();
}

class _MainBottomState extends State<MainBottom> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .pushReplacementNamed(ListFormModelsScreen.routeName);
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(AuthCheckScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(ListBackupValuesScreen.routeName);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.ballot_rounded),
          label: 'Modelos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lock_rounded),
          label: 'Autenticação',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.backup),
          label: 'Backups',
        ),
      ],
      currentIndex: widget.currentIndex,
      onTap: _onItemTapped,
    );
  }
}
