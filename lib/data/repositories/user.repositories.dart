import 'package:isar/isar.dart';
import 'package:isar_flutter_starter/data/models/user.dart';
import 'package:isar_flutter_starter/helpers/config/db.dart';

class UserRepository {
  Future<List<User>> getAppointments() async {
    final isar = await DB().db;
    return await isar.users.where().findAll();
  }

  Future<User> getAppointmentById(int id) async {
    final isar = await DB().db;
    return await isar.users.where().idEqualTo(id).findFirst() ??
        (throw Exception("User id $id tidak ada"));
  }

  Future<User> createAppointment(User appointment) async {
    final isar = await DB().db;
    await isar.writeTxn(() => isar.users.put(appointment));
    return appointment;
  }

  Future<User> updateAppointment(User appointment) async {
    final isar = await DB().db;
    await isar.writeTxn(() async {
      final existingAppointment = await isar.users.get(appointment.id);
      if (existingAppointment != null) {
        await isar.users.put(appointment);
      } else {
        throw Exception("User id ${appointment.id} tidak ada");
      }
    });
    return appointment;
  }

  Future<void> deleteAppointment(int id) async {
    final isar = await DB().db;
    await isar.writeTxn(() => isar.users.delete(id));
  }
}
