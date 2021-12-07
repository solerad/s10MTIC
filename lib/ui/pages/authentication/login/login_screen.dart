import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
                    onPressed: () {
                      Get.offNamed('/content');
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
