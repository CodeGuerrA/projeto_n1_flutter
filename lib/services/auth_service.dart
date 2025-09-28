class AuthService {
  static final AuthService instance = AuthService._internal();
  AuthService._internal();

  final Map<String, Map<String, String>> _users = {};
  String? _currentUser;

  // Estrutura: {username: {"password": "...", "altPassword": "..." }}

  Future<void> init() async {
    // Simulação sem persistência
  }

  Future<bool> register(String username, String password) async {
    if (_users.containsKey(username)) return false;
    _users[username] = {"password": password, "altPassword": ""};
    return true;
  }

  Future<bool> login(String username, String password) async {
    if (_users.containsKey(username) && _users[username]!["password"] == password) {
      _currentUser = username;
      return true;
    }
    return false;
  }

  Future<bool> loginWithAlt(String username, String altPassword) async {
    if (_users.containsKey(username) && _users[username]!["altPassword"] == altPassword) {
      _currentUser = username;
      return true;
    }
    return false;
  }

  Future<void> setAltPassword(String username, String altPassword) async {
    if (_users.containsKey(username)) {
      _users[username]!["altPassword"] = altPassword;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  String? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
}
