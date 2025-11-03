import 'package:flutter/material.dart';
import './screens/welcome_screen.dart';
import './screens/home_screen.dart';
import './screens/finish_screen.dart';
import './screens/game_over_screen.dart';
import './models/user_data.dart';

void main() {
  runApp(BrainErrorApp());
}

class BrainErrorApp extends StatefulWidget {
  @override
  _BrainErrorAppState createState() => _BrainErrorAppState();
}

class _BrainErrorAppState extends State<BrainErrorApp> {
  UserData? _userData;

  void _setUserData(String name) {
    setState(() {
      _userData = UserData(name: name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medan Guessr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: WelcomeScreen(
        onStart: _setUserData,
      ),
      routes: {
        '/home': (context) => HomeScreen(userData: _userData),
        '/finish': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
          return FinishScreen(
            level: args['level'],
            progress: args['progress'],
            userName: _userData?.name ?? 'Player',
          );
        },
        '/game-over': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
          return GameOverScreen(
            level: args['level'],
            userName: _userData?.name ?? 'Player',
          );
        },
      },
    );
  }
}
