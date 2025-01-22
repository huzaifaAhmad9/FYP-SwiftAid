import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' show log;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _dbRef.child('users').child(user.uid).set({
          'name': name,
          'email': email,
          'createdAt': DateTime.now().toIso8601String(),
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use.');
      } else if (e.code == 'weak-password') {
        throw Exception('The password is too weak.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is invalid.');
      } else {
        throw Exception('Failed to sign up: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<User?> siginwithGoogle() async {
    try {
      log('Starting Google Sign-In process.');

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log('Google Sign-In aborted by the user.');
        throw Exception('Google sign-in aborted.');
      }

      log('Google user signed in successfully: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      log('Retrieved Google auth tokens: '
          'accessToken=${googleAuth.accessToken}, idToken=${googleAuth.idToken}');

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      log('Signing in to Firebase with Google credentials.');

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      log('Firebase sign-in successful: '
          'userId=${userCredential.user?.uid}, email=${userCredential.user?.email}');

      return userCredential.user;
    } catch (e) {
      log('Error during Google sign-in: ${e.toString()}');
      throw Exception('Error during Google sign-in: ${e.toString()}');
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Incorrect password.');
      } else {
        throw Exception('Failed to sign in: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to log out: $e');
    }
  }

  Future<void> resetPassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception('User is not logged in.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
          'This operation is sensitive and requires recent authentication. Please log in again.',
        );
      } else {
        throw Exception('Failed to reset password: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else {
        throw Exception('Failed to send reset email: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
