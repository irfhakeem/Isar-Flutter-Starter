import 'package:flutter/material.dart';
import 'package:isar_flutter_starter/data/models/user.dart';
import 'package:isar_flutter_starter/data/repositories/user.repositories.dart';

class Authorscreen extends StatefulWidget {
  final int id;

  const Authorscreen({super.key, required this.id});

  @override
  State<Authorscreen> createState() => _AuthorscreenState();
}

class _AuthorscreenState extends State<Authorscreen> {
  User? author;

  Future<User> getAuthor() async {
    final author = await UserRepository().getAppointmentById(widget.id);
    return author;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAuthor().then((value) {
      setState(() {
        author = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Author Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Author ID: ${widget.id}'),
            Text('Author Name: ${author?.name}'),
            Text('Author Age: ${author?.age}'),
          ],
        ),
      ),
    );
  }
}
