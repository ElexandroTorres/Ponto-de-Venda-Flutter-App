import 'package:pontodevenda/domain/models/user.dart';

abstract class UserRepository {
  Future<List<User>> fetchUsers();
}
