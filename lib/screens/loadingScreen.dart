import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MOTİVASİYA',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            'Yüklənir...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
