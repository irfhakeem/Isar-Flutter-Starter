import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar_flutter_starter/presentation/screen/detailAuthor.screen.dart';

class AuthorCard extends StatelessWidget {
  final int id;
  final String name;
  final String age;
  final String avatar;

  const AuthorCard({
    super.key,
    required this.id,
    required this.name,
    required this.age,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Author screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detailauthorscreen(id: id)),
        );
      },
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          leading:
              avatar.isNotEmpty
                  ? Image.file(
                    File(avatar),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                  : const Icon(Icons.person),
          title: Text(name),
          subtitle: Text('Age: $age'),
        ),
      ),
    );
  }
}
