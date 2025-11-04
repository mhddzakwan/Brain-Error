import 'package:flutter/material.dart';
import '../widgets/level_card.dart';
import '../screens/question_screen.dart';
import '../data/quiz_data.dart';
import '../models/quiz_progress.dart';
import '../models/user_data.dart';

class HomeScreen extends StatefulWidget {
  final UserData? userData;

  const HomeScreen({Key? key, this.userData}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gunakan static variable untuk persist state
  static Map<int, QuizProgress> _levelProgress = {};

  void _updateProgress(int level, QuizProgress newProgress) {
    setState(() {
      _levelProgress[level] = newProgress;
    });
  }

  void _resetProgress(int level) {
    setState(() {
      _levelProgress[level] = QuizProgress(
        level: level,
        completedQuestions: List.filled(3, false),
        userAnswers: List.filled(3, -1),
        lives: 3,
      );
    });
  }

  QuizProgress _getProgressForLevel(int level) {
    if (!_levelProgress.containsKey(level)) {
      _levelProgress[level] = QuizProgress(
        level: level,
        completedQuestions: List.filled(3, false),
        userAnswers: List.filled(3, -1),
        lives: 3,
      );
    }
    return _levelProgress[level]!;
  }

  void _navigateToQuestionScreen(BuildContext context, QuizLevel level) {
    final progress = _getProgressForLevel(level.level);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionScreen(
          level: level,
          progress: progress,
          onProgressUpdate: (newProgress) =>
              _updateProgress(level.level, newProgress),
        ),
      ),
    );
  }

  void _showResetConfirmationDialog(BuildContext context, QuizLevel level) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Reset Progress?',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin mengulang ${level.name}?\nSemua progress akan direset.',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Tidak',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _resetProgress(level.level);
                Navigator.pop(context);
                _navigateToQuestionScreen(context, level);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF047B6D),
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Ya, Reset',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleLevelTap(BuildContext context, QuizLevel level) {
    final progress = _getProgressForLevel(level.level);

    if (progress.status == 'Selesai') {
      _showResetConfirmationDialog(context, level);
    } else {
      _navigateToQuestionScreen(context, level);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final levels = QuizData.getLevels();

    return Scaffold(
      backgroundColor: Color(0xFF00A99F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF047B6D),
        title: Text(
          'Medan Guessr',
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // warna ikon putih
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Arahkan ke WelcomeScreen (nama route-nya sesuaikan)
            Navigator.pushReplacementNamed(context, '/welcome');
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: levels.map((level) {
                  final progress = _getProgressForLevel(level.level);

                  return LevelCard(
                    levelName: level.name,
                    progress: progress.progressText,
                    status: progress.status,
                    bottomColor: _getLevelColor(level.level),
                    onTap: () => _handleLevelTap(context, level),
                    level: level.level,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return Color(0xFF4CAF50);
      case 2:
        return Color(0xFFFF9800);
      case 3:
        return Color(0xFFF44336);
      default:
        return Color(0xFF4CAF50);
    }
  }
}
