import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mi_chat_app/controllers/notification_controller.dart';
import 'package:mi_chat_app/providers/user_provider.dart';
import 'package:mi_chat_app/screens/home/conversations/widgets/conversation_list.dart';
import 'package:mi_chat_app/screens/home/conversations/widgets/header.dart';
import 'package:mi_chat_app/screens/home/users/users.dart';
import 'package:mi_chat_app/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    NotificationController().updateToken();
    NotificationController().handleForeground();
    NotificationController().setupInteractedMessage(context);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Logger().f(state);
    if (state == AppLifecycleState.resumed) {
      Provider.of<UserProvider>(context, listen: false)
          .updateOnlineStatus(true, context);
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .updateOnlineStatus(false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Header(),
              ConversationList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          CustomNavigation.nextPage(context, const UsersScreen());
        },
        child: const Icon(Icons.chat, color: Colors.white),
      ),
    );
  }
}
