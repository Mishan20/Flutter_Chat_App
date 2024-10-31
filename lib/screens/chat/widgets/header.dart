import 'package:flutter/material.dart';
import 'package:mi_chat_app/models/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.user,
    required this.userModel,
  });

  final UserModel? user;
  final UserModel? userModel;

  String formatName(String name) {
    return name.length > 10 ? '${name.substring(0, 5)}...' : name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),
      child: Row(
        children: [
          const BackButton(
            color: Colors.white,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage(user != null ? user!.image : userModel!.image),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatName(user != null ? user!.name : userModel!.name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user != null
                      ? user!.isOnline
                          ? "Online"
                          : timeago.format(DateTime.parse(user!.lastSeen))
                      : "Offline",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.white),
            onPressed: () {
              // Add your video call function here
            },
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {
              // Add your voice call function here
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Add additional options function here
            },
          ),
        ],
      ),
    );
  }
}
