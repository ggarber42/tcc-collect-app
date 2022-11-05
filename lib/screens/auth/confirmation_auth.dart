import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/auth/login.dart';
import '../../widgets/base_widgets/button_loading.dart';
import '../../widgets/custom_widgets/main_bottom.dart';
import '../../providers/auth_firebase.dart';
import '../../utils/helper.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../widgets/custom_widgets/main_drawer.dart';

class ConfirmationAuthScreen extends StatefulWidget {
  const ConfirmationAuthScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationAuthScreen> createState() => _ConfirmationAuthScreenState();
}

class _ConfirmationAuthScreenState extends State<ConfirmationAuthScreen> {
  bool loading = false;

  goToLoginScreen() {
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  _logOut() async {
    try {
      await context.read<AuthProvider>().logout();
      goToLoginScreen();
    } on AuthException catch (e) {
      setState(() => loading = false);
      Helper.showSnack(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainBar(),
        drawer: MainDrawer(),
        bottomNavigationBar: MainBottom(
          currentIndex: 1,
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Login feito  ;)',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: _logOut,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (loading)
                      ? [
                          ButtonLoading(
                            color: Colors.green,
                          ),
                        ]
                      : [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Logout',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                ),
              )
            ],
          ),
        ));
  }
}
