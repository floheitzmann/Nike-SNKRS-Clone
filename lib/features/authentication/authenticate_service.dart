import 'package:firebase_auth/firebase_auth.dart';
import 'package:nike_snkrs_clone/models/user_model.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(userId: user.uid, email: user.email);
      } else {
        return UserModel(userId: "userId");
      }
    });
  }

  Future<UserCredential?> signUp(UserModel user, String password) async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: password,
      );

      await verifyEmail();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signIn(UserModel user, String password) async {
    try {
      var userCredential = await auth.signInWithEmailAndPassword(
        email: user.email!,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> verifyEmail() async {
    User? user = auth.currentUser;

    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  Future<void> signOut() async {
    return await auth.signOut();
  }
}
