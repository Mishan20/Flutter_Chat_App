import 'package:flutter/material.dart';
import 'package:mi_chat_app/controllers/users_controller.dart';
import 'package:mi_chat_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  UsersController usersController = UsersController();

  Future<void> updateOnlineStatus(bool isOnline , BuildContext context) async {
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    await usersController.updateOnlineStatus(isOnline, uid);
  }
}
