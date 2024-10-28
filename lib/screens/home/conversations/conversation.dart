import 'package:flutter/material.dart';
import 'package:mi_chat_app/screens/home/conversations/widgets/conversation_list.dart';
import 'package:mi_chat_app/screens/home/conversations/widgets/header.dart';
import 'package:mi_chat_app/screens/home/users/users.dart';
import 'package:mi_chat_app/utils/navigation/custom_navigation.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
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
