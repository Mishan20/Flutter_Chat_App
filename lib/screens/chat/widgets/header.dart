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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(
          color: Colors.black,
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage:
              NetworkImage(user != null ? user!.image : userModel!.image),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user != null ? user!.name : userModel!.name,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              user != null
                  ? user!.isOnline
                      ? "Online"
                      : timeago.format(DateTime.parse(user!.lastSeen))
                  : "ofline",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
