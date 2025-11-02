import 'package:flutter/material.dart';
import '../widgets/level_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF00A99F),
      appBar: AppBar(
        backgroundColor: Color(0xFF047B6D),
        title: Text(
          'Uji Kebodohammu!',
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // warna icon back
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  LevelCard(
                    imagePath: 'images/wojak-level1.png',
                    levelName: 'Level 1 (Bodoh Ringan)',
                    progress: '5/5',
                    status: 'Selesai',
                    bottomColor: Color(0xFF4CAF50),
                  ),
                  LevelCard(
                    imagePath: 'images/wojak-level2.png',
                    levelName: 'Level 2 (Bodoh Akut)',
                    progress: '2/5',
                    status: 'Lanjutkan',
                    bottomColor: Color(0xFFFF9800),
                  ),
                  LevelCard(
                    imagePath: 'images/wojak-level3.png',
                    levelName: 'Level 3 (Termul)',
                    progress: '0/5',
                    status: 'Mulai',
                    bottomColor: Color(0xFFF44336),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
