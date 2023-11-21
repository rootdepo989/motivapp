// home.dart

import 'package:flutter/material.dart';

class MotivasiyaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🚀 Ana Səhifə 🚀'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/your_image.jpg'), // Öz şəkillərinizi əlavə edin
              radius: 50.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Daima ən yaxşısını vermək üçün hazır olun!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Həyatınızın rəngini dəyişdirin və hər gününüzü motivasiya ilə başlayın.',
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
