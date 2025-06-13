import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

 // GitHub token methods
  static Future<void> saveGitHubToken(String token) async {
    await _storage.write(key: 'github_token', value: token);
  }

  static Future<String?> getGitHubToken() async {
    return await _storage.read(key: 'github_token');
  }

  static Future<void> deleteGitHubToken() async {
    await _storage.delete(key: 'github_token');
  }

  // Gemini API key methods
  static Future<void> saveGeminiApiKey(String apiKey) async {
    await _storage.write(key: 'gemini_api_key', value: apiKey);
  }

  static Future<String?> getGeminiApiKey() async {
    return await _storage.read(key: 'gemini_api_key');
  }

  static Future<void> deleteGeminiApiKey() async {
    await _storage.delete(key: 'gemini_api_key');
  }
}