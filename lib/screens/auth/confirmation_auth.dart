import 'package:collect_app/widgets/custom_widgets/main_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/base_widgets/main_drawer.dart';

class ConfirmationAuthScreen extends StatelessWidget {
  const ConfirmationAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainBar(),
        drawer: MainDrawer(),
        body: Center(
          child: Text(
            'Login feito ;)',
            style: TextStyle(fontSize: 25),
          ),
        ));
  }
}
