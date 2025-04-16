import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class User {
  User(this.name, this.age, this.avatar);
  Id id = Isar.autoIncrement;
  String name;
  int age;
  String avatar;
}
