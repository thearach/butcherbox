import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChanges();
  Future<User> signInWithGoogle();
  Future<User> signInAnonymously();
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();
  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
            code: 'MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google Id Token');
      }
    } else {
      throw FirebaseAuthException(
          code: 'ERROR - Aborted by User', message: 'Sign In aborted by User');
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await _firebaseAuth.signOut();
    googleSignIn.signOut();
  }
}
