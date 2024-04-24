import 'package:flutter/material.dart';
import 'package:pokedex/repositories/user_repository.dart';
import 'package:pokedex/stores/app_store.dart';
import 'package:pokedex/stores/user_preferences_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final UserRepository _userRepository = UserRepository();
  final SharedPreferences _prefs = UserPreferencesStore.getPreferences();
  late AppStore _appStore;
  BuildContext? _context;

  void init(BuildContext context) {
    _context = context;
    _appStore = Provider.of<AppStore>(context);
  }

  Future<bool> login(String nickname, String password) async {
    try {
      final user = await _userRepository.getUserByNickName(nickname);

      if (user != null && user.password == password) {
        _prefs.setBool('logged', true);
        _prefs.setInt('id', user.id!);
        _prefs.setString('avatar', user.avatar ?? '');
        _prefs.setString('nickname', user.nickname!);

        Navigator.pushReplacementNamed(_context!, '/home');

        return true;
      }

      throw Exception('Falha na autenticação. Verifique seu e-mail e senha.');
    } catch (error) {
      final errorMessage =
          _formatErrorMessage(error, 'Ocorreu um erro na tentativa de login');

      _appStore.setErrorMessage(errorMessage);

      return false;
    }
  }

  Future<bool> register(String nickname, String password) async {
    try {
      final user = await _userRepository.getUserByNickName(nickname);

      if (user != null) {
        throw Exception('Este nickname já está sendo usado por outro usuário.');
      }

      await _userRepository.createUser(nickname, password);

      Navigator.pushReplacementNamed(_context!, '/login');

      return true;
    } catch (error) {
      final errorMessage =
          _formatErrorMessage(error, 'Ocorreu um erro ao criar o usuário');

      _appStore.setErrorMessage(errorMessage);

      return false;
    }
  }

  String _formatErrorMessage(error, String defaultMessage) {
    return error is Exception
        ? error.toString().replaceFirst('Exception: ', '')
        : defaultMessage;
  }
}
