import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:isar_flutter_starter/data/models/user.dart';
import 'package:isar_flutter_starter/data/repositories/user.repository.dart';
import 'package:isar_flutter_starter/helpers/utils/upload.dart';
import 'package:isar_flutter_starter/presentation/widget/authorCard.dart';

class Authorscreen extends StatefulWidget {
  const Authorscreen({super.key});

  @override
  State<Authorscreen> createState() => _AuthorscreenState();
}

class _AuthorscreenState extends State<Authorscreen> {
  String? imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final String fileName = path.basename(pickedFile.path);
      final savedPath = await handleImageUpload(imageFile, fileName);

      setState(() {
        imagePath = savedPath;
      });

      debugPrint('Image saved at: $savedPath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authors')),
      body: StreamBuilder<List<User>>(
        stream: UserRepository().getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No author found'));
          } else {
            final authors = snapshot.data!;
            return ListView.builder(
              itemCount: authors.length,
              itemBuilder: (context, index) {
                final author = authors[index];
                return AuthorCard(
                  id: author.id,
                  name: author.name,
                  age: author.age.toString(),
                  avatar: author.avatar, // optional: tampilkan gambar
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              final nameController = TextEditingController();
              final ageController = TextEditingController();

              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Add Author',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: ageController,
                        decoration: const InputDecoration(labelText: 'Age'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Pick Image'),
                      ),
                      if (imagePath != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Selected Image:',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Image.file(
                          File(imagePath!),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ],
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          final name = nameController.text;
                          final age = int.tryParse(ageController.text);

                          if (name.isNotEmpty && age != null) {
                            await UserRepository().createUser(
                              User(name, age, imagePath ?? ''),
                            );

                            if (mounted) {
                              Navigator.pop(context);
                              setState(() {
                                imagePath = null;
                              });
                            }
                          }
                        },
                        child: const Text(
                          'Add Author',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
