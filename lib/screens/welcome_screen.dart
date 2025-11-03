import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final Function(String) onStart;

  const WelcomeScreen({Key? key, required this.onStart}) : super(key: key);

  void _showNameInputDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Siapa Namamu?',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Container(
            width: screenWidth * 0.8, // Fixed width agar tidak melebar
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama kamu...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                isDense: true, // Agar lebih compact
              ),
              style: TextStyle(fontSize: screenWidth * 0.04),
              autofocus: true,
              maxLines: 1, // Hanya satu baris
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                // Submit ketika tekan enter
                _submitName(context, nameController.text.trim());
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _submitName(context, nameController.text.trim());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF047B6D),
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Mulai Game',
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

  void _submitName(BuildContext context, String name) {
    if (name.isNotEmpty) {
      onStart(name); // Simpan nama
      Navigator.pop(context); // Tutup dialog
      Navigator.pushNamed(context, '/home'); // Navigate ke home
    } else {
      // Tampilkan pesan error jika nama kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nama tidak boleh kosong!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF00A99F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Medan Guessr',
              style: TextStyle(
                fontSize: screenWidth * 0.12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Container(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              child: Image.asset(
                'assets/images/welcome-medan.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Text(
                'Dimana posisi le?, papkan lah dulu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.08),
            ElevatedButton(
              onPressed: () {
                _showNameInputDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                minimumSize: Size(
                  screenWidth * 0.5,
                  screenHeight * 0.06,
                ),
              ),
              child: Text(
                'Mulai',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
