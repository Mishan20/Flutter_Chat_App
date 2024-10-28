import 'package:flutter/material.dart';
import 'package:mi_chat_app/screens/chat/chat_screen.dart';
import 'package:mi_chat_app/utils/navigation/custom_navigation.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                CustomNavigation.nextPage(context, const ChatScreen());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade800,
                ),
                child: ListTile(
                  title: const Text(
                    "Ishan Senanayaka",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Hello",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("10:30 AM",
                          style: TextStyle(
                              color: Colors.grey.shade400, fontSize: 12)),
                      const Icon(
                        Icons.done_all,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
