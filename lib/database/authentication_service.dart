import 'package:firebase_auth/firebase_auth.dart';
import 'package:jogo_das_equacoes/database/dao/player_dao.dart';
import 'package:jogo_das_equacoes/database/firebase-message.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> delete() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser.delete();
        return 'O usuário foi excluído com sucesso!';
      }
      return 'Erro: O usuário já foi excluido ou não está logado!';
    } on FirebaseAuthException catch (e) {
      return (FirebaseMessage().verifyErroCode(e.code));
    }
  }

  Future<dynamic> register({String email, String password}) async {
    try {
      final User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return user;
    } on FirebaseAuthException catch (e) {
      return (FirebaseMessage().verifyErroCode(e.code));
    }
  }

  Future<dynamic> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      return (FirebaseMessage().verifyErroCode(e.code));
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Signed Op';
    } on FirebaseAuthException catch (e) {
      return (FirebaseMessage().verifyErroCode(e.code));
    }
  }
}
