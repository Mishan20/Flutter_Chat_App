import 'package:flutter/material.dart';
import 'package:mi_chat_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "My Chats",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                Provider.of<AuthProvider>(context).user!.photoURL!,
              ),
            ),
            IconButton(onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            }, icon: const Icon(Icons.exit_to_app))
          ],
        ),
        const Divider(),
      ],
    );
  }
}
