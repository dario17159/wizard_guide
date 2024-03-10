import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveObject(String jsonData, String key) async {
    await _storage.write(key: key, value: jsonData);
  }

  static Future<String?> getObject(String key) async {
    return await _storage.read(key: key);
  }
}
