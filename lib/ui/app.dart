import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/use_cases/controllers/auth_controller.dart';
import 'package:red_egresados/ui/pages/authentication/auth_page.dart';
import 'package:red_egresados/ui/pages/content/content_page.dart';
import 'package:red_egresados/ui/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // Este widget es la raíz de su aplicación.
  @override
  Widget build(BuildContext context) {
    // Llamamos el método que inicializa el estado
    _stateManagementInit();
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
       // ---------------------------------------
       // 1. Crea las rutas posibles para nuestra app
       // ---------------------------------------
      routes: {
        '/auth': (context) => const AuthenticationPage(),
        '/content': (context) => const ContentPage(),
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
  }
}
