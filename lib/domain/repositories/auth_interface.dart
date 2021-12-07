abstract class AuthInterface {
  Future<bool> signUp( //Registro de usuario
      {required String name, required String email, required String password});

  // Inicio de sesion
  Future<bool> signIn({required String email, required String password});

  // Cerrar sesion
  Future<bool> signOut();
}