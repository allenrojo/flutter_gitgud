import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;

Future<String?> signInWithGitHub() async {
  try {
    final clientId = dotenv.env['GITHUB_CLIENT_ID']!;
    final clientSecret = dotenv.env['GITHUB_CLIENT_SECRET']!;
    final redirectUrl = dotenv.env['GITHUB_REDIRECT_URL']!;

    final authUrl =
        'https://github.com/login/oauth/authorize'
        '?client_id=$clientId'
        '&redirect_uri=${Uri.encodeComponent(redirectUrl)}'
        '&scope=user:email%20repo'  // Add 'repo' scope if you want repo info
        '&state=randomstate123';

    final result = await FlutterWebAuth2.authenticate(
      url: authUrl,
      callbackUrlScheme: 'gitgudapp',
    );

    final uri = Uri.parse(result);
    final code = uri.queryParameters['code'];

    if (code == null) {
      print('No authorization code received');
      return null;
    }

    final tokenResponse = await http.post(
      Uri.parse('https://github.com/login/oauth/access_token'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code,
        'redirect_uri': redirectUrl,
      },
    );

    if (tokenResponse.statusCode == 200) {
      final tokenData = json.decode(tokenResponse.body);
      final accessToken = tokenData['access_token'];
      if (accessToken != null) {
        print('Successfully got access token');
        return accessToken;
      }
    }

    print('Failed to get access token');
    return null;
  } catch (e, stackTrace) {
    print('GitHub OAuth error: $e');
    print('Stack trace: $stackTrace');
    return null;
  }
}
