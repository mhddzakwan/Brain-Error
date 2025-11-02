import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/welcome_screen.dart';

void main() {
  runApp(BrainErrorApp());
}

class BrainErrorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Error',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
