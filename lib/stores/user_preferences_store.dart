import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesStore {
  static UserPreferencesStore? _instance;
  late SharedPreferences _prefs;

  // Construtor privado
  UserPreferencesStore._internal();

  // Método para obter a instância da classe
  static UserPreferencesStore getInstance() {
    return _instance ??= UserPreferencesStore._internal();
  }

  static SharedPreferences getPreferences() {
    if (_instance == null) {
      throw Exception("UserPreferencesStore não foi inicializado");
    }

    return _instance!._prefs;
  }

  // Método de inicialização
  Future<void> init() async {
    _instance!._prefs = await SharedPreferences.getInstance();
  }
}
