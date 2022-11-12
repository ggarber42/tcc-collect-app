import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/auth/confirmation_auth.dart';
import '../../screens/auth/login.dart';
import '../../providers/auth_firebase.dart';

class AuthCheckScreen extends StatefulWidget {
  static const routeName = '/auth_checker';
  const AuthCheckScreen({Key? key}) : super(key: key);

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  Widget loading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    if (auth.isLoading) {
      return loading();
    } else if (auth.user == null) {
      return LoginScreen();
    } else {
      return ConfirmationAuthScreen();
    }
  }
}
