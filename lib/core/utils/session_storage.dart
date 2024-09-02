import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Save login credentials
  Future<void> saveLoginSession(String username, String token) async {
    await _secureStorage.write(key: 'username', value: username);
    await _secureStorage.write(key: 'token', value: token);
  }

  // Get login credentials
  Future<Map<String, String?>> getLoginSession() async {
    String? username = await _secureStorage.read(key: 'username');
    String? token = await _secureStorage.read(key: 'token');
    return {'username': username, 'token': token};
  }

  // Get login credentials
  Future<String?> getToken() async {
    String? token = await _secureStorage.read(key: 'token');
    return token;
  }

  // Clear login credentials
  Future<void> clearLoginSession() async {
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'token');
  }
}
