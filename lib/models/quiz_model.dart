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
    if (correctAnswers == 0 && !isLevelCompleted) return 'Mulai';
    if (isLevelCompleted) return 'Selesai';
    return 'Lanjutkan';
  }

  int get stars {
    if (lives == 3) return 3;
    if (lives == 2) return 2;
    if (lives == 1) return 1;
    return 0;
  }
}

class QuizState {
  final Map<int, QuizProgress> levelProgress;

  QuizState({required this.levelProgress});

  QuizState copyWith({Map<int, QuizProgress>? levelProgress}) {
    return QuizState(
      levelProgress: levelProgress ?? this.levelProgress,
    );
  }

  QuizProgress getProgressForLevel(int level) {
    return levelProgress[level] ??
        QuizProgress(
          level: level,
          completedQuestions: List.filled(3, false),
          userAnswers: List.filled(3, -1),
          lives: 3,
        );
  }
}
