import 'package:pokedex/core/connect.dart';
import 'package:pokedex/models/user_model.dart';

class UserRepository {
  Future<int> createUser(String nickname, String password) async {
    final data = {
      'nickname': nickname.toString(),
      'password': password.toString(),
    };

    return await Connect.create('users', data);
  }

  Future<UserModel?> getUserByNickName(String nickname) async {
    final result = await Connect.where('users', 'nickname = ?', [nickname]);

    return result.isNotEmpty ? UserModel.fromJson(result.first) : null;
  }

  Future<int> updateAvatar(String path, int id) async {
    return await Connect.update('users', id, {'avatar': path});
  }
}
