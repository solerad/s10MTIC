import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:retociclo4/domain/use_cases/controllers/auth_controller.dart';
import 'package:retociclo4/domain/use_cases/controllers/conectivity_controller.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onViewSwitch, onForgotPassword;

  //Constructor
  const LoginScreen({
    Key? key, 
  required this.onViewSwitch, 
  required this.onForgotPassword
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final connectivityController = Get.find<ConnectivityController>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Entra a tu cuenta",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              obscureText: _isObscure,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Clave',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }, 
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off
                  )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    // ---------------------------------------
                    // 1. Implementa el metodo onPressed para ejecutar una acción al presionar el boton 'Iniciar Sesiòn'
                    // ---------------------------------------
                    onPressed: () async {
                      if (connectivityController.connected) {
                        var result = await controller.manager.signIn(
                          email: emailController.text,
                          password: passwordController.text);
                          controller.authenticated = result;
                          // Validamos que el resultado sea falso, para enviarle 
                          // Una alerta al usuario diciendo, que los datos 
                          // Son errados, usando Get.showSnackbar
                          if (result == false) {
                            Get.showSnackbar(
                              GetBar(
                                message: "Usuario o contraseña incorrecto",
                                duration: const Duration(seconds: 2),
                              )
                            );
                          }
                      } else {
                        Get.showSnackbar(
                          GetBar(
                            message: "No estas conectado a la red.",
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
              )
            ],
          ),
          const Text('Si no tienes una cuenta, da clic aquí: '),
          TextButton(
              onPressed: widget.onViewSwitch, 
              child: const Text("Registrarse")),
          SignInButton(
            Buttons.GoogleDark,
            onPressed: () => controller.manager.signInWithGoogle(),
          ),
          const Spacer(),
          TextButton(
            onPressed: widget.onForgotPassword, 
            child: const Text('Olvidé mi contraseña')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
