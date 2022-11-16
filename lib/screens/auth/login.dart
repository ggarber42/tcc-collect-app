import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_firebase.dart';
import '../../widgets/base_widgets/button_loading.dart';
import '../../widgets/custom_widgets/main_bottom.dart';
import '../../widgets/custom_widgets/main_bar.dart';
import '../../screens/auth/auth_check.dart';
import '../../utils/helper.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLogin = true;
  bool loading = false;
  late String title;
  late String actionButton;
  late String toggleButton;

  setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        title = 'Bem-vindo';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        title = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login.';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  goToAuthCheckScreen() {
    Navigator.of(context).pushReplacementNamed(AuthCheckScreen.routeName);
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthProvider>().login(email.text, password.text);
      goToAuthCheckScreen();
    } on AuthException catch (e) {
      setState(() => loading = false);
      Helper.showSnack(context, e.message);
    }
  }

  register() async {
    setState(() => loading = true);
    try {
      await context.read<AuthProvider>().register(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      Helper.showSnack(context, e.message);
    }
    goToAuthCheckScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainBar(),
      bottomNavigationBar: MainBottom(
        currentIndex: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(title,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    )),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o email corretamente!';
                      }
                      if (!Helper.validateEmail(value)) {
                        return 'Informe um email válido!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informa sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          register();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading)
                          ? [ButtonLoading()]
                          : [
                              Icon(Icons.check),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  actionButton,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(toggleButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
