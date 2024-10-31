import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:mi_chat_app/models/message_model.dart';
import 'package:mi_chat_app/models/user_model.dart';
import 'package:mi_chat_app/providers/chat_provider.dart';
import 'package:mi_chat_app/screens/chat/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

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
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder(
                stream: Provider.of<ChatProvider>(context).startListenToUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ChatHeader(user: null, userModel: widget.user);
                  }
                  if (snapshot.hasError) {
                    return ChatHeader(user: null, userModel: widget.user);
                  }
                  UserModel? user = snapshot.data;
                  return ChatHeader(user: user, userModel: widget.user);
                },
              ),
              const Divider(color: Colors.grey),
              Expanded(
                child: StreamBuilder(
                  stream: Provider.of<ChatProvider>(context, listen: false).getAllMessages(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("Error", style: TextStyle(color: Colors.white)));
                    }
                    if (snapshot.hasData) {
                      List<MessageModel> messages = snapshot.data!;
                      return Consumer<ChatProvider>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                                    child: Align(
                                      alignment: widget.user!.uid != messages[index].uid
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Text(
                                        timeago.format(messages[index].time),
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  BubbleSpecialThree(
                                    text: messages[index].message,
                                    color: widget.user!.uid != messages[index].uid
                                        ? const Color(0xFF1B97F3)
                                        : Colors.grey.shade700,
                                    delivered: true,
                                    seen: true,
                                    isSender: widget.user!.uid != messages[index].uid,
                                    tail: true,
                                    textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              Container(
                height: 70,
                color: Colors.black87,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            controller: Provider.of<ChatProvider>(context, listen: false).messageController,
                            maxLines: 2,
                            minLines: 1,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Message",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false).startSendMessage(context);
                      },
                      icon: const Icon(Icons.send, color: Colors.blue),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}