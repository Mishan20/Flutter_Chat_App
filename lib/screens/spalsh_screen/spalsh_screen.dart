import 'dart:async';


import 'package:flutter/material.dart';
import 'package:mi_chat_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';


class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return const SpalshScreen();
    //   }));
    // });

    Timer(const Duration(seconds: 3), () {
      Provider.of<AuthProvider>(context, listen: false)
          .listenToAuthState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 100,
            color: Colors.amber.shade700,
          ),
          Text(
            "MI Chat",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade700),
          ),
        ],
      )),
    );
  }
}
