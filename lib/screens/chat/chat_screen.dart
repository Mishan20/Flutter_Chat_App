import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:mi_chat_app/models/user_model.dart';
import 'package:mi_chat_app/providers/chat_provider.dart';
import 'package:mi_chat_app/screens/chat/widgets/header.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? user;
  const ChatScreen({super.key, this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder(
                stream:
                    Provider.of<ChatProvider>(context).startListenToUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ChatHeader(user: null, userModel: widget.user);
                  }
                  if (snapshot.hasError) {
                    return ChatHeader(user: null, userModel: widget.user);
                  }
                  UserModel? user = snapshot.data;
                  return ChatHeader(user: user, userModel: widget.user);
                }),
            const Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15),
                          child: Align(
                              alignment: index.isEven
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: const Text("10:00 AM",
                                  style: TextStyle(color: Colors.grey))),
                        ),
                        BubbleSpecialThree(
                          text: 'Please try and give some feedback on it!',
                          color: index.isEven
                              ? const Color(0xFF1B97F3)
                              : Colors.grey.shade600,
                          delivered: true,
                          seen: true,
                          isSender: index.isEven,
                          tail: false,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    );
                  }),
            ),
            Container(
              height: 70,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(25)),
                        child: TextField(
                          controller:
                              Provider.of<ChatProvider>(context, listen: false)
                                  .messageController,
                          maxLines: 2,
                          minLines: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                          ),
                        )),
                  )),
                  IconButton(
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .startSendMessage(context);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
