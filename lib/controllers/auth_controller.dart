import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:mi_chat_app/models/user_model.dart';

class AuthController {
  final users = FirebaseFirestore.instance.collection("Users");

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

// Future<UserCredential?> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken?.token);

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }

  Future<void> saveUserData(UserModel user) async {
    try {
      await users.doc(user.uid).set(user.toJson());
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> userSignOut() async {
    try {
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Logger().e(e);
    }
  }
}
