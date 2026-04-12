// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Thái Anh Tú',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'MSSV: 2224802010543',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const Divider(height: 32),
                const Row(
                  children: [
                    Icon(Icons.school, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text('Đại Học Thủ Dầu Một'),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.email, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text('tuthai332@gmail.com'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}