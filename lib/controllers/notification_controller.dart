import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mi_chat_app/models/user_model.dart';
import 'package:mi_chat_app/providers/chat_provider.dart';
import 'package:mi_chat_app/screens/chat/chat_screen.dart';
import 'package:mi_chat_app/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class NotificationController {
  final users = FirebaseFirestore.instance.collection('Users');

  Future<void> updateToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    await users.doc(uid).update({
      'token': token ?? "",
    }).then((value) {
      Logger().f(token);
    });
  }

  void handleForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().f('Got a message whilst in the foreground!');
      Logger().f('Message data: ${message.data}');

      if (message.notification != null) {
        Logger().f(
            'Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> setupInteractedMessage(BuildContext context) async {
    // Get any messages which caused the application to open from
    // a terminated state.

    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      if (value != null) {
        _handleMessage(value, context);
      }
    });

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message, context);
    });
  }

  void _handleMessage(RemoteMessage message, BuildContext context) {
    Logger().f(message.data);
    if (message.data['uid'] != null) {
      Provider.of<ChatProvider>(context, listen: false).setUser(UserModel(
        name: message.data['name'],
        image: message.data['image'],
        uid: message.data['uid'],
        lastSeen: DateTime.now().toString(),
        isOnline: true,
      ));
      CustomNavigation.nextPage(
          context,
          ChatScreen(
            user: UserModel(
              name: message.data['name'],
              image: message.data['image'],
              uid: message.data['uid'],
              lastSeen: DateTime.now().toString(),
              isOnline: true,
            ),
          ));
    }
  }
}
