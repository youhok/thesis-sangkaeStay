import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign In with email/username and password
  Future<Map<String, dynamic>> signIn(String identifier, String password) async {
    try {
      String? email;

      if (identifier.contains('@')) {
        email = identifier.trim();
      } else {
        String normalizedUsername = identifier.trim().replaceAll(RegExp(r'\s+'), ' ');
        var querySnapshot = await _firestore
            .collection('users')
            .where('username', isEqualTo: normalizedUsername)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          email = querySnapshot.docs.first['email'];
        } else {
          throw Exception("User not found. Check your username or sign up.");
        }
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password,
      );

      String? token = await userCredential.user!.getIdToken();

      return {
        'user': userCredential.user,
        'token': token,
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign Up with email, password, and username
  Future<Map<String, dynamic>> signUp(String email, String password, String username) async {
    try {
      // Check if username is already taken
      var usernameCheck = await _firestore
          .collection('users')
          .where('username', isEqualTo: username.trim())
          .get();

      if (usernameCheck.docs.isNotEmpty) {
        throw Exception("Username is already taken");
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Store user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email.trim(),
        'username': username.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      String? token = await userCredential.user!.getIdToken();

      return {
        'user': userCredential.user,
        'token': token,
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign In with Phone Number (returns verificationId for the next step)
  Future<String> signInWithPhone(String phoneNumber) async {
    try {
      Completer<String> completer = Completer();

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-resolution on Android
          UserCredential userCredential = await _auth.signInWithCredential(credential);
          String? token = await userCredential.user?.getIdToken();
          completer.complete(token ?? '');
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(Exception(e.message));
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
        },
      );

      return completer.future;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Verify Phone Code
  Future<Map<String, dynamic>> verifyPhoneCode(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      String? token = await userCredential.user!.getIdToken();

      // Store phone number if it's a new user
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'phoneNumber': userCredential.user!.phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return {
        'user': userCredential.user,
        'token': token,
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign In with Google
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Google Sign-In cancelled");
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      String? token = await userCredential.user!.getIdToken();

      // Store user data if new user
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'username': googleUser.displayName ?? userCredential.user!.email!.split('@')[0],
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return {
        'user': userCredential.user,
        'token': token,
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Forgot Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      throw Exception("Error sending password reset email: ${e.toString()}");
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // Sign out from Google if used
      await _auth.signOut(); // Sign out from Firebase
    } catch (e) {
      throw Exception("Error signing out: ${e.toString()}");
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}



// final authService = AuthService();

// // Sign In
// try {
//   var result = await authService.signIn("username or email", "password");
//   print(result['user'].uid);
// } catch (e) {
//   print(e);
// }

// // Sign Up
// try {
//   var result = await authService.signUp("email@example.com", "password", "username");
// } catch (e) {
//   print(e);
// }

// // Phone Sign In
// try {
//   String verificationId = await authService.signInWithPhone("+1234567890");
//   // Show UI to enter code
//   var result = await authService.verifyPhoneCode(verificationId, "123456");
// } catch (e) {
//   print(e);
// }

// // Google Sign In
// try {
//   var result = await authService.signInWithGoogle();
// } catch (e) {
//   print(e);
// }

// // Reset Password
// try {
//   await authService.resetPassword("email@example.com");
// } catch (e) {
//   print(e);
// }

// // Sign Out
// try {
//   await authService.signOut();
// } catch (e) {
//   print(e);
// }