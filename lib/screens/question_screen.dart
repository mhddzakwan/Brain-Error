import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/quiz_progress.dart';
import '../widgets/option_item.dart';
import 'finish_screen.dart';
import 'game_over_screen.dart';

class QuestionScreen extends StatefulWidget {
  final QuizLevel level;
  final QuizProgress progress;
  final Function(QuizProgress) onProgressUpdate;

  const QuestionScreen({
    Key? key,
    required this.level,
    required this.progress,
    required this.onProgressUpdate,
  }) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int? selectedOptionIndex;
  bool showResult = false;
  bool isCorrect = false;
  late int currentLives;
  late QuizProgress _currentProgress;

  @override
  void initState() {
    super.initState();
    _currentProgress = widget.progress.copyWith(
      completedQuestions: List<bool>.from(widget.progress.completedQuestions),
      userAnswers: List<int>.from(widget.progress.userAnswers),
    );
    currentLives = _currentProgress.lives;

    final previousAnswer =
        _currentProgress.userAnswers[_currentProgress.currentQuestion];
    if (previousAnswer != -1) {
      selectedOptionIndex = previousAnswer;
    }
  }

  QuizQuestion get currentQuestion {
    return widget.level.questions[_currentProgress.currentQuestion];
  }

  void _showHintDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                'Hint',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: Text(
            currentQuestion.hint,
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
                'Tutup',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Color(0xFF047B6D),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleOptionSelect(int index) {
    if (showResult) return;

    setState(() {
      selectedOptionIndex = index;
    });
  }

  void _checkAnswer() {
    if (selectedOptionIndex == null) return;

    final isAnswerCorrect =
        selectedOptionIndex == currentQuestion.correctAnswerIndex;

    // Update lives immediately
    int newLives = currentLives;
    if (!isAnswerCorrect) {
      newLives = currentLives - 1;
    }

    setState(() {
      showResult = true;
      isCorrect = isAnswerCorrect;
      currentLives = newLives; // Update currentLives immediately
    });

    // Update progress
    final newCompletedQuestions =
        List<bool>.from(_currentProgress.completedQuestions);
    final newUserAnswers = List<int>.from(_currentProgress.userAnswers);

    newUserAnswers[_currentProgress.currentQuestion] = selectedOptionIndex!;

    if (isAnswerCorrect) {
      newCompletedQuestions[_currentProgress.currentQuestion] = true;
    }

    final newProgress = _currentProgress.copyWith(
      completedQuestions: newCompletedQuestions,
      userAnswers: newUserAnswers,
      lives: newLives,
    );

    _currentProgress = newProgress;

    // Update progress to home screen immediately
    widget.onProgressUpdate(newProgress);

    Future.delayed(Duration(milliseconds: 1000), () {
      if (isAnswerCorrect) {
        _goToNextQuestion(newProgress);
      } else {
        if (newLives <= 0) {
          _goToGameOver();
        } else {
          setState(() {
            showResult = false;
            selectedOptionIndex = null;
          });
        }
      }
    });
  }

  void _goToNextQuestion(QuizProgress progress) {
    final nextQuestionIndex = progress.currentQuestion + 1;

    if (nextQuestionIndex < widget.level.questions.length) {
      final newProgress = progress.copyWith(currentQuestion: nextQuestionIndex);
      widget.onProgressUpdate(newProgress);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionScreen(
            level: widget.level,
            progress: newProgress,
            onProgressUpdate: widget.onProgressUpdate,
          ),
        ),
      );
    } else {
      // LEVEL COMPLETED - Navigate ke FinishScreen menggunakan route name
      widget.onProgressUpdate(progress);

      Navigator.pushNamed(
        context,
        '/finish',
        arguments: {
          'level': widget.level,
          'progress': progress,
        },
      );
    }
  }

  void _goToGameOver() {
    // Reset progress untuk level ini
    final resetProgress = QuizProgress(
      level: widget.level.level,
      completedQuestions: List.filled(3, false),
      userAnswers: List.filled(3, -1),
      lives: 3,
    );

    // Update progress yang di-reset ke home screen
    widget.onProgressUpdate(resetProgress);

    Navigator.pushNamed(
      context,
      '/game-over',
      arguments: {
        'level': widget.level,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF00A99F),
      appBar: AppBar(
        backgroundColor: Color(0xFF047B6D),
        title: Text(
          widget.level.name,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            widget.onProgressUpdate(_currentProgress);
            Navigator.pop(context);
          },
        ),
        actions: [
          // Hint Button
          IconButton(
            icon: Icon(Icons.lightbulb_outline, color: Colors.white),
            onPressed: _showHintDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_currentProgress.currentQuestion + 1}/${widget.level.questions.length}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.favorite,
                        color: index < currentLives ? Colors.red : Colors.grey,
                        size: screenWidth * 0.06,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  // Gambar soal - lebih besar karena tidak ada teks soal
                  Container(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.6,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(currentQuestion.imagePath),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),

                  // Options list
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        final option = currentQuestion.options[index];
                        return OptionItem(
                          text: option,
                          isSelected: index == selectedOptionIndex,
                          isWrong: showResult &&
                              index == selectedOptionIndex &&
                              !isCorrect,
                          isCorrect: showResult &&
                              isCorrect &&
                              index ==
                                  selectedOptionIndex, // HIJAU hanya untuk jawaban yang dipilih dan benar
                          onTap: () => _handleOptionSelect(index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: selectedOptionIndex != null && !showResult
                  ? _checkAnswer
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF047B6D),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                showResult ? (isCorrect ? 'Benar!' : 'Salah!') : 'Periksa',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
