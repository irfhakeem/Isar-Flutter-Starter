import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar_flutter_starter/data/models/book.dart';
import 'package:isar_flutter_starter/data/repositories/book.repository.dart';
import 'package:isar_flutter_starter/presentation/screen/detailAuthor.screen.dart';

class Detailbookscreen extends StatefulWidget {
  final int id;

  const Detailbookscreen({super.key, required this.id});

  @override
  State<Detailbookscreen> createState() => _DetailbookscreenState();
}

class _DetailbookscreenState extends State<Detailbookscreen> {
  Book? book;

  Future<Book> getBook() async {
    final book = await BookRepository().getBookByID(widget.id);
    return book;
  }

  @override
  void initState() {
    super.initState();
    getBook().then((value) {
      setState(() {
        book = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Screen')),
      body:
          book == null
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                child: Column(
                  children: [
                    Image.file(File(book?.cover ?? 'assets/images/cover.png')),
                    Text(book!.title, style: const TextStyle(fontSize: 20)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    Detailauthorscreen(id: book!.authorId),
                          ),
                        );
                      },
                    ),
                    Text(
                      book!.yearPublished.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      book?.genre ?? 'Unknown',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
    );
  }
}
