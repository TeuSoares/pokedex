import 'package:pokedex/repositories/user_repository.dart';
import 'package:pokedex/stores/user_preferences_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  final SharedPreferences _prefs = UserPreferencesStore.getPreferences();
  final UserRepository _userRepository = UserRepository();

  Future<void> updateAvatar(String path) async {
    final id = _prefs.getInt('id')!;

    await _userRepository.updateAvatar(path, id);
  }
}
