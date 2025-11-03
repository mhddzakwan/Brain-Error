class QuizLevel {
  final int level;
  final String name;
  final String description;
  final List<QuizQuestion> questions;

  QuizLevel({
    required this.level,
    required this.name,
    required this.description,
    required this.questions,
  });
}

class QuizQuestion {
  final int id;
  final String imagePath;
  final String hint;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.id,
    required this.imagePath,
    required this.hint,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizData {
  static List<QuizLevel> getLevels() {
    return [
      // LEVEL 1 (TURIS)
      QuizLevel(
        level: 1,
        name: 'Level 1 (Tourist/Pengunjung)',
        description: 'Tourist',
        questions: [
          QuizQuestion(
            id: 1,
            imagePath: 'assets/images/medan-level1-1.jpg',
            hint:
                'Sering jadi spot foto anak muda yang mau pamer “lagi di Medan nih!”',
            options: [
              'Menara Air Tirtanadi',
              'Tong Setan',
              'Bolu Menara',
            ],
            correctAnswerIndex: 0,
          ),
          QuizQuestion(
            id: 2,
            imagePath: 'assets/images/medan-level1-2.jpg',
            hint: 'New York versi KW di Medan',
            options: [
              'Carefour',
              'Manhattan',
              'Vocal Point',
            ],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 3,
            imagePath: 'assets/images/medan-level1-3.jpg',
            hint: 'Peninggalan kerajaan Melayu yang jadi ikon kota Medan',
            options: [
              'Masjid Al Ikhlas',
              'Masjid Raya Medan',
              'Istana Maimun',
            ],
            correctAnswerIndex: 2,
          ),
        ],
      ),

      // LEVEL 2 (PENDATANG BARU)
      QuizLevel(
        level: 2,
        name: 'Level 2 (Pendatang Baru)',
        description: 'Pendatang Baru',
        questions: [
          QuizQuestion(
            id: 4,
            imagePath: 'assets/images/medan-level2-1.jpg',
            hint: 'Duren nomor 1 di Medan',
            options: [
              'Pelawi Durian',
              'Ucok Durian',
              'Si Bolang Durian',
            ],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 5,
            imagePath: 'assets/images/medan-level2-2.jpg',
            hint: 'Dekat Lapangan Merdeka, bangunan peninggalan Belanda',
            options: [
              'Gedung London Sumatra (Lonsum)',
              'Kantor Pos Medan',
              'Gedung Bank Indonesia Medan',
            ],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 6,
            imagePath: 'assets/images/medan-level2-3.jpg',
            hint: 'Tempatnya si Bobby',
            options: [
              'Kantor Bank Indonesia',
              'Kantor Wali Kota Medan',
              'Kantor Gubernur Sumatera Utara',
            ],
            correctAnswerIndex: 2,
          ),
        ],
      ),

      // LEVEL 3 (ANAK MEDAN)
      QuizLevel(
        level: 3,
        name: 'Level 3 (Anak Medan)',
        description: 'Tingkat Anak Medan',
        questions: [
          QuizQuestion(
            id: 7,
            imagePath: 'assets/images/medan-level3-1.jpg',
            hint: 'Pasar tradisional yang namanya dijadikan nama kecamatan',
            options: [
              'Pajus',
              'Sie Kambing',
              'Petisah',
            ],
            correctAnswerIndex: 2,
          ),
          QuizQuestion(
            id: 8,
            imagePath: 'assets/images/medan-level3-2.jpg',
            hint: 'Julukannya “Little India” di Medan',
            options: [
              'Vihara Gunung Timur',
              'Kampung Keling',
              'Desa India',
            ],
            correctAnswerIndex: 1,
          ),
          QuizQuestion(
            id: 9,
            imagePath: 'assets/images/medan-level3-3.jpg',
            hint: 'Simpang legendaris yang sering jadi patokan arah',
            options: [
              'Simpang Pos',
              'Simpang Glugur',
              'Simpang Limun',
            ],
            correctAnswerIndex: 0,
          ),
        ],
      ),
    ];
  }
}
