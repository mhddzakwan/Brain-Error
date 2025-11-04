class QuizProgress {
  final int level;
  final int currentQuestion;
  final List<bool> completedQuestions;
  final List<int> userAnswers;
  final int lives;

  QuizProgress({
    required this.level,
    this.currentQuestion = 0,
    required this.completedQuestions,
    required this.userAnswers,
    this.lives = 3,
  });

  QuizProgress copyWith({
    int? currentQuestion,
    List<bool>? completedQuestions,
    List<int>? userAnswers,
    int? lives,
  }) {
    return QuizProgress(
      level: level,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      completedQuestions: completedQuestions ?? this.completedQuestions,
      userAnswers: userAnswers ?? this.userAnswers,
      lives: lives ?? this.lives,
    );
  }

  bool get isLevelCompleted {
    return completedQuestions.every((element) => element);
  }

  bool get isGameOver {
    return lives <= 0;
  }

  int get correctAnswers {
    return completedQuestions.where((element) => element).length;
  }

  String get progressText {
    return '$correctAnswers/${completedQuestions.length}';
  }

  String get status {
    if (isLevelCompleted) return 'Selesai';
    if (correctAnswers > 0) return 'Lanjutkan';
    return 'Mulai';
  }

  int get stars {
    if (lives == 3) return 3;
    if (lives == 2) return 2;
    if (lives == 1) return 1;
    return 0;
  }

  @override
  String toString() {
    return 'QuizProgress(level: $level, currentQuestion: $currentQuestion, completed: $completedQuestions, lives: $lives, status: $status)';
  }
}
