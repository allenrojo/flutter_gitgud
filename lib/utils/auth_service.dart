import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> signInWithGitHub() async {
  try {
    final clientId = dotenv.env['GITHUB_CLIENT_ID']!;
    final clientSecret = dotenv.env['GITHUB_CLIENT_SECRET']!;
    final redirectUrl = dotenv.env['GITHUB_REDIRECT_URL']!;

    print('🔵 Starting GitHub OAuth...');
    print('🔵 Client ID: $clientId');
    print('🔵 Redirect URL: $redirectUrl');

    // Step 1: Build authorization URL
    final authUrl =
        'https://github.com/login/oauth/authorize'
        '?client_id=$clientId'
        '&redirect_uri=${Uri.encodeComponent(redirectUrl)}'
        '&scope=user:email'
        '&state=randomstate123';

    print('🔵 Auth URL: $authUrl');

    // Step 2: Launch web auth
    final result = await FlutterWebAuth2.authenticate(
      url: authUrl,
      callbackUrlScheme: 'gitgudapp',
    );

    print('🔵 Web auth result: $result');

    // Step 3: Extract authorization code
    final uri = Uri.parse(result);
    final code = uri.queryParameters['code'];

    if (code == null) {
      print('🔴 No authorization code received');
      return false;
    }

    print('🔵 Authorization code: $code');

    // Step 4: Exchange code for access token
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

    print('🔵 Token response: ${tokenResponse.body}');

    if (tokenResponse.statusCode == 200) {
      final tokenData = json.decode(tokenResponse.body);
      final accessToken = tokenData['access_token'];

      if (accessToken != null) {
        print('🟢 Successfully got access token');
        return true;
      }
    }

    print('🔴 Failed to get access token');
    return false;
  } catch (e, stackTrace) {
    print('🔴 GitHub OAuth error: $e');
    print('🔴 Stack trace: $stackTrace');
    return false;
  }
}
