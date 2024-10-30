import 'package:flutter/material.dart';
import 'package:mi_chat_app/models/conversation_model.dart';
import 'package:mi_chat_app/providers/chat_provider.dart';
import 'package:mi_chat_app/screens/chat/chat_screen.dart';
import 'package:mi_chat_app/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationList extends StatelessWidget {
  const ConversationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: Provider.of<ChatProvider>(context, listen: false)
              .startFetchConversation(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            }
            List<ConversationModel> conversations = snapshot.data!;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .setUser(conversations[index].user);
                      CustomNavigation.nextPage(
                          context,
                          ChatScreen(
                            user: conversations[index].user,
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade800,
                      ),
                      child: ListTile(
                        title: Text(
                          conversations[index].user.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        subtitle: Text(
                          conversations[index].lastMessage,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(timeago.format(conversations[index].lastTime),
                                style: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 12)),
                            const Icon(
                              Icons.done_all,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            conversations[index].user.image,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
