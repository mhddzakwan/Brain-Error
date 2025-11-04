import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/quiz_progress.dart';
import 'home_screen.dart';

class FinishScreen extends StatelessWidget {
  final QuizLevel level;
  final QuizProgress progress;
  final String userName;

  const FinishScreen({
    Key? key,
    required this.level,
    required this.progress,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF00A99F),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.celebration,
                size: screenWidth * 0.3,
                color: Colors.yellow,
              ),
              SizedBox(height: 24),
              Text(
                'Selamat!',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '$userName telah menyelesaikan',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.white,
                ),
              ),
              Text(
                level.name,
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.star,
                      size: screenWidth * 0.15,
                      color:
                          index < progress.stars ? Colors.yellow : Colors.grey,
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              Text(
                _getStarsDescription(progress.stars),
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF047B6D),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Kembali ke Home',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStarsDescription(int stars) {
    switch (stars) {
      case 3:
        return 'Sempurna! Tidak ada jawaban salah';
      case 2:
        return 'Bagus! Hanya 1 jawaban salah';
      case 1:
        return 'Cukup! 2 jawaban salah';
      default:
        return 'Coba lagi!';
    }
  }
}
