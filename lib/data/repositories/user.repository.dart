import 'package:isar/isar.dart';
import 'package:isar_flutter_starter/data/models/user.dart';
import 'package:isar_flutter_starter/helpers/config/db.dart';

class UserRepository {
  Stream<List<User>> getUsersStream() async* {
    final isar = await DB().db;
    yield* isar.users.where().watch(fireImmediately: true);
  }

  Future<List<User>> getUser() async {
    final isar = await DB().db;
    return await isar.users.where().findAll();
  }

  Future<User> getUserById(int id) async {
    final isar = await DB().db;
    return await isar.users.where().idEqualTo(id).findFirst() ??
        (throw Exception("User id $id tidak ada"));
  }

  Future<User> createUser(User user) async {
    final isar = await DB().db;
    await isar.writeTxn(() => isar.users.put(user));
    return user;
  }

  Future<User> updateUser(User user) async {
    final isar = await DB().db;
    await isar.writeTxn(() async {
      final existingUser = await isar.users.get(user.id);
      if (existingUser != null) {
        await isar.users.put(user);
      } else {
        throw Exception("User id ${user.id} tidak ada");
      }
    });
    return user;
  }

  Future<void> deleteUser(int id) async {
    final isar = await DB().db;
    await isar.writeTxn(() => isar.users.delete(id));
  }
}
