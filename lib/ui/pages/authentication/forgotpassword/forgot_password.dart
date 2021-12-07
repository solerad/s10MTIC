// Primero Importar el paquete de material.dart
import 'package:flutter/material.dart';

// Segundo (Tener extensión Awesome Flutter Snippets) 
// Con el teclado usar Ctrl + Espacio
// Escribir sta --> Escogen cuál Widget quieren crear
// Definir el nombre de el Widget

class ForgotPasswordScreen extends StatefulWidget {
  // Definir las variables que vamos a utilizar en nuestro widget
  // Generalmente estas se solicitan en el constructor
  final VoidCallback onViewSwitch, onSignUp;

  // Constructor, (colocar "const" en caso de que salga la línea azul)
  // Se definen los parámetros que necesitamos que nos envíen
  // Cada vez que llamen a este Widget
  const ForgotPasswordScreen({
    Key? key,
    required this.onViewSwitch,
    required this.onSignUp
  }) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
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
              "Recupera tu contraseña",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
          TextButton(
              onPressed: () {}, 
              child: const Text("Recuperar Contraseña")),
          const Spacer(),
          TextButton(
            onPressed: widget.onViewSwitch, 
            child: const Text('Regresar a Inicio de Sesión')),
          const SizedBox(
            height: 10.0,
          ),
          const Text('Si no tienes una cuenta, presiona aquí:'),
          TextButton(
            onPressed: widget.onSignUp, 
            child: const Text('Registro de Usuario')),
        ],
      ),
    );
  }
}

