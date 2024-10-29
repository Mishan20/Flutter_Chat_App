import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mi_chat_app/controllers/chat_controller.dart';
import 'package:mi_chat_app/models/conversation_model.dart';
import 'package:mi_chat_app/models/message_model.dart';
import 'package:mi_chat_app/models/user_model.dart';
import 'package:mi_chat_app/providers/auth_provider.dart' as my_auth_provider;
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  UserModel? _me;
  UserModel? get me => _me;

  UserModel? _user;
  UserModel? get user => _user;

  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  Stream<UserModel> startListenToUserData() {
    final stream = ChatController().listenToUser(_user!.uid);
    stream.listen((model) {
      _user = model;
    });
    return stream;
  }

  void setUser(UserModel model) {
    _user = model;
    notifyListeners();
  }

  Future<void> startSendMessage(BuildContext context) async {
    if (_messageController.text.isNotEmpty) {
      User user =
          Provider.of<my_auth_provider.AuthProvider>(context, listen: false)
              .user!;
      _me = UserModel(
          name: user.displayName!,
          image: user.photoURL!,
          uid: user.uid,
          lastSeen: DateTime.now().toString(),
          isOnline: false);
      MessageModel message = MessageModel(
          uid: _me!.uid,
          message: _messageController.text,
          time: DateTime.now(),
          id: "");

      ConversationModel senderConModel = ConversationModel(
          user: _user!,
          lastMessage: _messageController.text,
          lastTime: DateTime.now());

      ConversationModel recieverConModel = ConversationModel(
          user: _me!,
          lastMessage: _messageController.text,
          lastTime: DateTime.now());

      ChatController()
          .sendMessage(senderConModel, recieverConModel, message, context)
          .then((value) {
        _messageController.clear();
        notifyListeners();
      });
    }
  }
}
