import 'package:hive/hive.dart';

part 'hive_modal.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  late final String username;

  @HiveField(1)
  final String email;

  @HiveField(2)
  late final String password;

  User({required this.username, required this.email, required this.password});
}
