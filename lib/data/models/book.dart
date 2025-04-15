import 'package:isar/isar.dart';
part 'book.g.dart';

@collection
class Book {
  Book(
    this.title,
    this.author,
    this.yearPublished,
    this.authorId,
    this.cover,
    this.genre,
  );
  Id id = Isar.autoIncrement;
  int authorId;
  String author;
  String title;
  int yearPublished;
  String? genre;
  String cover;
}
