import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<User> signIn({required String email, required String password}) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      return user.user!;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signUp({required String email, required String password, required String displayName}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.reload();
      }

      return user!;
    } catch (e) {
      rethrow;
    }
  }
}
