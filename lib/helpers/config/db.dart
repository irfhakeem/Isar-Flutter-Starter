import 'package:isar/isar.dart';
import 'package:isar_flutter_starter/data/models/book.dart';
import 'package:isar_flutter_starter/data/models/user.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  static final DB _instance = DB._internal();
  factory DB() => _instance;

  late Future<Isar> db;

  DB._internal() {
    db = _openDB();
  }

  Future<Isar> _openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([UserSchema, BookSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }
}
