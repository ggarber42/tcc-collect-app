import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
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
            leading: Icon(Icons.ballot_rounded ),
            title: Text('Modelos'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.filter_vintage_sharp),
            title: Text('Configurações'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
