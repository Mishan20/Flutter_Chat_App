import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mi_chat_app/controllers/users_controller.dart';
import 'package:mi_chat_app/models/user_model.dart';
import 'package:mi_chat_app/utils/navigation/custom_navigation.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../chat/chat_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  color: Colors.grey.shade300,
                ),
                Text(
                  "Contacts",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade700,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: UsersController().getAllUSers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text("Something went wrong"));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    List<UserModel> uList = [];

                    for (var user in snapshot.data!.docs) {
                      UserModel u = UserModel.fromJson(
                        user.data() as Map<String, dynamic>,
                      );
                      uList.add(u);
                    }

                    return ListView.builder(
                        itemCount: uList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: GestureDetector(
                              onTap: () {
                                CustomNavigation.nextPage(
                                    context, const ChatScreen());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade800,
                                ),
                                child: ListTile(
                                  title: Text(
                                    uList[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: Text(
                                    uList[index].isOnline
                                        ? "Online"
                                        : timeago.format(DateTime.parse(
                                            uList[index].lastSeen)),
                                    style:
                                        TextStyle(color: Colors.grey.shade500),
                                  ),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      uList[index].image,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
