import 'package:flutter/material.dart';
import 'package:isar_flutter_starter/data/models/book.dart';
import 'package:isar_flutter_starter/data/repositories/book.repository.dart';
import 'package:isar_flutter_starter/presentation/widget/bookCard.dart';

class Bookscreen extends StatefulWidget {
  const Bookscreen({super.key});

  @override
  State<Bookscreen> createState() => _BookscreenState();
}

class _BookscreenState extends State<Bookscreen> {
  List<Book>? books;

  Future<List<Book>> getBooks() async {
    final books = await BookRepository().getBooks();
    return books;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooks().then((value) {
      setState(() {
        books = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: Expanded(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          child: StreamBuilder<List<Book>>(
            stream: BookRepository().getBooksStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No books available');
              } else {
                final books = snapshot.data!;
                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return BookCard(
                      id: book.id,
                      cover: book.cover,
                      title: book.title,
                      author: book.author,
                      yearPublished: book.yearPublished,
                      genre: book.genre ?? 'Unknown',
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
