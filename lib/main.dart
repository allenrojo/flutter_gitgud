import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/pages/home.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';
import 'package:flutter_application_gitgud/pages/welcome.dart';
import '../utils/colors.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _secureStorage = FlutterSecureStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  final token = await _secureStorage.read(key: 'github_token');
  runApp(MainApp(token:token));
}

class MainApp extends StatelessWidget {
  final String? token;
  const MainApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: customPurple,
        fontFamily: 'nunito_regular',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: token != null ? Topics(accessToken: token!) : const Welcome(),
      routes: {
        '/welcome': (context) => const Welcome(),
        '/home': (context) => Home(accessToken: token ?? '', repositories: []),
      },
    );
  }
}
