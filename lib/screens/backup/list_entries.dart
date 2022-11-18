import 'package:collect_app/widgets/custom_widgets/backup_entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_firebase.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/custom_widgets/main_bottom.dart';

import '../../models/entry.dart';

class ListBackupEntriesScreen extends StatefulWidget {
  final String modelName;
  final List<Entry> entries;

  ListBackupEntriesScreen(this.modelName, this.entries);

  @override
  State<ListBackupEntriesScreen> createState() =>
      _ListBackupEntriesScreenState();
}

class _ListBackupEntriesScreenState extends State<ListBackupEntriesScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final userId = auth.getUserId();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MainBar(
        windowTitle: 'Backups - ${widget.modelName}',
      ),
      bottomNavigationBar: MainBottom(currentIndex: 2),
      body: Container(
        height: size.height * 0.8,
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.entries.length,
            itemBuilder: ((context, index) =>
                BackupEntryTile(widget.entries[index], userId)),
          ),
        ),
      ),
    );
  }
}
