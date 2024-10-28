// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mi_chat_app/controllers/auth_controller.dart';
import 'package:mi_chat_app/models/user_model.dart';
import 'package:mi_chat_app/screens/auth/sign_in_page.dart';
import 'package:mi_chat_app/screens/home/conversations/conversation.dart';
import 'package:mi_chat_app/utils/navigation/custom_navigation.dart';

class AuthProvider extends ChangeNotifier {
  AuthController authController = AuthController();

  User? _user;
  User? get user => _user;

  Future<void> listenToAuthState(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().e('User is currently signed out!');
        CustomNavigation.nextPage(context, const SignInPage());
      } else {
        Logger().f('User is signed in!');
        _user = user;
        notifyListeners();
        CustomNavigation.nextPage(context, const ConversationScreen());
      }
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final credential = await authController.signInWithGoogle();

    if (credential != null) {
      UserModel user = UserModel(
        name: _user!.displayName!,
        image: _user!.photoURL!,
        uid: _user!.uid,
        lastSeen: DateTime.now().toString(),
        isOnline: true,
      );
      await authController.saveUserData(user);
    }
  }

  Future<void> signOut() async {
    await authController.userSignOut();
  }
}
