import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mi_chat_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Set up fade-in animation
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward(); // Start the animation

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Provider.of<AuthProvider>(context, listen: false)
          .listenToAuthState(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when screen is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Image
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                    'assets/splash/chat_app_icon.png'), // Replace with your image asset path
              ),
              const SizedBox(height: 20),
              // MI Chat Text with subtle scaling animation
              ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.1).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: Text(
                  "MI Chat",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
