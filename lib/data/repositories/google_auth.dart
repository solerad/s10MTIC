import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:retociclo4/domain/repositories/auth_interface.dart';

class GoogleAuth implements AuthInterface {
  @override
  Future<bool> signInWithGoogle() async {
    try {
      // Creamos una variable que almacenará la info del usuario que inicie
      // Sesión con Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtenemos los detalles de autenticación para hacer el proceso
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Creamos la nueva credencial
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  // En caso de error
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
