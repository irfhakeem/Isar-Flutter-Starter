import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar_flutter_starter/presentation/screen/bookScreen.dart';

class MyCard extends StatelessWidget {
  final int id;
  final String cover;
  final String title;
  final String author;
  final String yearPublished;
  final String genre;

  const MyCard({
    super.key,
    required this.id,
    required this.cover,
    required this.title,
    required this.author,
    required this.yearPublished,
    required this.genre,
  });

  static const Map<String, Color> genreColor = {
    'Fiction': Colors.red,
    'Non-Fiction': Colors.blue,
    'Science': Colors.green,
    'History': Colors.yellow,
    '': Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Example')),
      body: GestureDetector(
        onTap: () {
          // Navigate to Bookscreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Bookscreen(id: id)),
          );
        },
        child: Card(
          color: genreColor[genre] ?? Colors.grey,
          child: Column(
            children: [
              Image.file(File(cover)),
              Text(title, style: const TextStyle(fontSize: 20)),
              Text(author, style: const TextStyle(fontSize: 16)),
              Text(yearPublished, style: const TextStyle(fontSize: 14)),
              Text(genre, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
