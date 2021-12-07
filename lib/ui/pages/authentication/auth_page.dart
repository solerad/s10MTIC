import 'package:flutter/material.dart';
import 'package:red_egresados/ui/app.dart';
import 'package:red_egresados/ui/pages/authentication/forgotpassword/forgot_password.dart';
import 'package:red_egresados/ui/pages/authentication/login/login_screen.dart';
import 'package:red_egresados/ui/pages/authentication/signup/singup_screen.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AuthenticationPage> {
  Widget? _content;

  // NavBar action
  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 1:
        // Inicio de Sesión
          _content = LoginScreen(
            onViewSwitch: () => _onItemTapped(2), //Llamo al caso 2
            onForgotPassword: () => _onItemTapped(3), //Llamo al caso 3
          );
          break;
        case 2:
        // Registro de Usuario
          _content = SignUpScreen(
            onViewSwitch: () => _onItemTapped(1), //Llamo al caso 1
          );
          break;
        case 3:
        // Olvido de contraseña
          _content = ForgotPasswordScreen(
            onViewSwitch: () => _onItemTapped(1), //Llamo al caso 1
            onSignUp: () => _onItemTapped(2), //Llamo al caso 2
          );
          break;
      }
    });
  }

  // Inicializo el estado con el contenido apuntando 
  // Al widget de inicio de sesión
  @override
  void initState() {
    super.initState();
    _content = LoginScreen(onViewSwitch: () => _onItemTapped(2), onForgotPassword: () => _onItemTapped(3));
  }

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _content,
          ),
        ),
      ),
    );
  }
}
