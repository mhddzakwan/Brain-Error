import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isWrong;
  final bool isCorrect; // Tambahkan parameter isCorrect
  final VoidCallback onTap;

  const OptionItem({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.isWrong = false,
    this.isCorrect = false, // Default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Color getBorderColor() {
      if (isCorrect) return Colors.green; // Hijau untuk jawaban benar
      if (isWrong) return Colors.red;
      if (isSelected) return Color(0xFF1086D5);
      return Colors.grey.shade300;
    }

    Color getBackgroundColor() {
      if (isCorrect) return Colors.green; // Hijau transparan untuk benar
      if (isWrong) return Colors.red;
      if (isSelected) return Color(0xFF1086D5);
      return Colors.white;
    }

    Color getTextColor() {
      if (isCorrect) return Colors.white;
      ; // Teks hijau untuk jawaban benar
      if (isWrong) return Colors.white;
      if (isSelected) return Colors.white;
      return Colors.black87;
    }

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: getBorderColor(),
          width:
              isSelected || isWrong || isCorrect ? 2 : 1, // Tambahkan isCorrect
        ),
      ),
      color: getBackgroundColor(),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          text,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: getTextColor(), // Gunakan fungsi getTextColor
            fontWeight:
                isSelected || isCorrect ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: getBorderColor(),
              width: 2,
            ),
            color:
                isSelected || isCorrect ? getBorderColor() : Colors.transparent,
          ),
          child: isSelected || isCorrect
              ? Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                )
              : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
