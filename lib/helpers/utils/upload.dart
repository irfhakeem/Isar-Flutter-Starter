import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> handleImageUpload(File imageFile, String fileName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/assets/image';

    final imageDir = Directory(imagePath);
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }

    final newImagePath = '$imagePath/$fileName';
    final newImageFile = File(newImagePath);
    await imageFile.copy(newImageFile.path);

    return newImageFile.path; // <- return full path
  } catch (e) {
    throw PlatformException(
      code: 'IMAGE_UPLOAD_ERROR',
      message: 'Failed to upload image: $e',
    );
  }
}
