import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  // Reads GEMINI_API_KEY from the default .env file loaded by dotenv.load()
  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  static Future<String?> generateSummary(String prompt) async {
    final endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_apiKey';

    final requestBody = {
      "prompt": {
        "text": prompt,
      },
      "temperature": 0.7,
      "candidateCount": 1,
      "maxOutputTokens": 200,
    };

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final candidates = data['candidates'] as List<dynamic>?;
      if (candidates != null && candidates.isNotEmpty) {
        return candidates[0]['output'] as String?;
      }
    } else {
      print('Gemini API error: ${response.statusCode} ${response.body}');
    }
    return null;
  }
}
