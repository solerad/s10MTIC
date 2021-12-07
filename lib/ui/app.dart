import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:retociclo4/data/repositories/auth.dart';
import 'package:retociclo4/domain/repositories/auth_interface.dart';
import 'package:retociclo4/domain/use_cases/auth_management.dart';
import 'package:retociclo4/domain/use_cases/controllers/auth_controller.dart';
import 'package:retociclo4/domain/use_cases/controllers/conectivity_controller.dart';
import 'package:retociclo4/domain/use_cases/controllers/status_controller.dart';
import 'package:retociclo4/ui/pages/authentication/auth_page.dart';
import 'package:retociclo4/ui/pages/content/content_page.dart';
import 'package:retociclo4/ui/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Inicializamos FireBase en un futuro
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // Este widget es la raíz de su aplicación.
  @override
  Widget build(BuildContext context) {
    // Llamamos el método que inicializa el estado
    _stateManagementInit();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Center(
              child: Text("Hubo un error con firebase"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          _firebaseStateInit();
          return GetMaterialApp(
            title: 'Red Egresados MinTIC',
            // Quitamos el banner DEBUG
            debugShowCheckedModeBanner: false,
            // Establecemos el tema claro
            theme: MyTheme.ligthTheme,
            // Establecemos el tema oscuro
            darkTheme: MyTheme.darkTheme,
            // Por defecto tomara la seleccion del sistema
            themeMode: ThemeMode.system,
            home: const AuthenticationPage(),
            // We add the two possible routes
            routes: {
              '/auth': (context) => const AuthenticationPage(),
              '/content': (context) => const ContentPage(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(
          home: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  // Creamos el método que inicializará 
// Los manejos de estado _stateManagementInit
void _stateManagementInit() {

    // Inyectamos el controlador y lo nombramos authController
    AuthController authController = Get.put(AuthController());

    // Con el método ever escuchamos cuando haya cambios en la
    // Variables a través del método reactivo reactiveAuth
    // Y definimos la variable que retorna como "isAuthenticated"
    // La cual es un boolean
    ever(authController.reactiveAuth, (bool isAuthenticated) {
      // En caso de que esté autenticado, nos lleva a la ruta /content, 
      // Usamos Get.off que no permite regresar a las vistas anteriores
      // En caso de que no esté autenticado, nos envía inmediatamente a 
      // La ruta /auth que muestra el inicio de sesión
      if (isAuthenticated) {
        Get.offNamed('/content');
      } else {
        Get.offNamed('/auth');
      }
      // Esta navegación a las rutas se llevará a cabo inmediatamente
      // Que haya cambios en la autenticación, gracias al método reactivo
    });

    // Inyectamos el controlador de conectividad
    ConnectivityController connectivityController =
        Get.put(ConnectivityController());

    // Verificamos la conectividad, y escuchamos los cambios,
    // Para asignar el valor a la variable observable del controlador
    Connectivity().onConnectivityChanged.listen((connectivityStatus) {
          log("connection changed to: $connectivityStatus");
          connectivityController.connectivity = connectivityStatus;
          if (connectivityStatus == ConnectivityResult.mobile) {
            Get.showSnackbar(
              GetBar(
                message: "Conectado con datos móviles",
                duration: const Duration(seconds: 2),)
            );
          } else if (connectivityStatus == ConnectivityResult.wifi) {
            Get.showSnackbar(
              GetBar(
                message: "Conectado con WiFi",
                duration: const Duration(seconds: 2),)
            );
          } else if (connectivityStatus == ConnectivityResult.none) {
            Get.showSnackbar(
              GetBar(
                message: "No está conectado a Internet",
                duration: const Duration(seconds: 2),)
            );
          }
        });

    // Inyectamos el controlador de estados
    StatusController statusController = Get.put(StatusController());
  }

_firebaseStateInit() {
    AuthController authController = Get.find<AuthController>();
    // Setting manager
    authController.authManagement = AuthManagement(
      auth: Auth()
    );
    // Watching auth state changes
    AuthInterface.authStream.listen(
      (user) => authController.currentUser = user,
    );
  }

}
