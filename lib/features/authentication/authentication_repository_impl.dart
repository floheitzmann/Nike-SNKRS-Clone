import 'package:firebase_auth/firebase_auth.dart';
import 'package:nike_snkrs_clone/features/authentication/authenticate_service.dart';
import 'package:nike_snkrs_clone/features/database/database_service.dart';
import 'package:nike_snkrs_clone/models/user_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationService service = AuthenticationService();
  DatabaseService dbService = DatabaseService();

  @override
  Stream<UserModel> getCurrentUser() {
    return service.retrieveCurrentUser();
  }

  @override
  Future<UserCredential?> signIn(UserModel user, String password) {
    try {
      return service.signIn(user, password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut() {
    return service.signOut();
  }

  @override
  Future<UserCredential?> signUp(UserModel user, String password) {
    try {
      return service.signUp(user, password);
    } on FirebaseException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }
}

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(UserModel user, String password);
  Future<UserCredential?> signIn(UserModel user, String password);
  Future<void> signOut();
}
