import 'package:flutter/material.dart';
import 'package:isar_flutter_starter/data/models/user.dart';
import 'package:isar_flutter_starter/data/repositories/user.repository.dart';

class Detailauthorscreen extends StatefulWidget {
  final int id;

  const Detailauthorscreen({super.key, required this.id});

  @override
  State<Detailauthorscreen> createState() => _DetailauthorscreenState();
}

class _DetailauthorscreenState extends State<Detailauthorscreen> {
  User? author;

  Future<User> getAuthor() async {
    final author = await UserRepository().getUserById(widget.id);
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        final nameController = TextEditingController();
                        final ageController = TextEditingController();

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller:
                                    nameController..text = author?.name ?? '',
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                ),
                              ),
                              TextField(
                                controller:
                                    ageController
                                      ..text = author?.age.toString() ?? '',
                                decoration: const InputDecoration(
                                  labelText: 'Age',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () async {
                                  final name = nameController.text;
                                  final age = int.tryParse(ageController.text);
                                  if (author != null) {
                                    author!.name = name;
                                    author!.age = age ?? 0;
                                  }

                                  if (name.isNotEmpty && age != null) {
                                    await UserRepository().updateUser(author!);
                                    if (mounted) {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    }
                                  }
                                },
                                child: Text(
                                  'Save Author',
                                  style: TextStyle(
                                    color:
                                        nameController.text.isNotEmpty &&
                                                int.tryParse(
                                                      ageController.text,
                                                    ) !=
                                                    null
                                            ? Colors.white
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  child: Text('Edit Author'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                              'Are you sure you want to delete this author?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await UserRepository().deleteUser(widget.id);
                                  if (mounted) {
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop();
                                  }
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete Author'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
