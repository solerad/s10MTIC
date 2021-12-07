// Importamos la interfaz
import 'package:red_egresados/domain/repositories/auth_interface.dart';

// Implementamos la interfaz en la clase
class Auth implements AuthInterface {
  
  // Reescribimos cada uno de los métodos de la interfaz
  // Para el inicio de sesión definimos los valores que por ahora serán válidos
  // Para ingresar a la sesión
  @override
  Future<bool> signIn({required String email, required String password}) async {
    final emailVal = "ejemplo@example.com" == email;
    final passwordVal = "Pass123!" == password;
    return emailVal && passwordVal;
  }

  @override
  Future<bool> signOut() async {
    return true;
  }

  // Para la creación de usuario definimos las condiciones que deben cumplir 
  // Las variables de email y password

  @override
  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final emailVal = email.contains("@") && email.contains(".co");
    final passwordVal = password.length > 6;
    return emailVal && passwordVal;
  }
}