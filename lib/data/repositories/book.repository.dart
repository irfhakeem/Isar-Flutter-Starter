import 'package:isar/isar.dart';
import 'package:isar_flutter_starter/data/models/book.dart';
import 'package:isar_flutter_starter/helpers/config/db.dart';

class BookRepository {
  Stream<List<Book>> getBooksStream() async* {
    final isar = await DB().db;
    yield* isar.books.where().watch(fireImmediately: true);
  }

  Future<List<Book>> getBooks() async {
    final isar = await DB().db;
    return await isar.books.where().findAll();
  }

  Future<Book> getBookByID(int id) async {
    final isar = await DB().db;
    return await isar.books.where().idEqualTo(id).findFirst() ??
        (throw Exception("Book id $id tidak ada"));
  }

  Future<Book> createBook(Book book) async {
    final isar = await DB().db;
    await isar.writeTxn(() => isar.books.put(book));
    return book;
  }

  Future<Book> updateBook(Book book) async {
    final isar = await DB().db;
    await isar.writeTxn(() async {
      final existingBook = await isar.books.get(book.id);
      if (existingBook != null) {
        await isar.books.put(book);
      } else {
        throw Exception("Book id ${book.id} tidak ada");
      }
    });
    return book;
  }

  Future<void> deleteBook(int id) async {
    final isar = await DB().db;
    await isar.writeTxn(() => isar.books.delete(id));
  }
}
