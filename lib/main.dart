import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/pages/home.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';
import 'package:flutter_application_gitgud/pages/welcome.dart';
import 'package:flutter_application_gitgud/utils/github_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 

final _secureStorage = FlutterSecureStorage();

Future<List<String>?> loadSelectedTopics() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('selected_topics');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final token = await _secureStorage.read(key: 'github_token');
  final selectedTopics = await loadSelectedTopics();

  runApp(MainApp(token: token, selectedTopics: selectedTopics));
}

class MainApp extends StatelessWidget {
  final String? token;
  final List<String>? selectedTopics;

  const MainApp({super.key, this.token, this.selectedTopics});

  @override
  Widget build(BuildContext context) {
    Widget home;

    if (token == null) {
      home = const Welcome();
    } else if (selectedTopics == null || selectedTopics?.isEmpty == true) {
      home = Topics(accessToken: token!);
    } else {
      home = SplashScreen(token: token!, selectedTopics: selectedTopics!);
    }
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
      home: home, //token != null ? Topics(accessToken: token!) : const Welcome(),
      routes: {
        '/welcome': (context) => const Welcome(),
        '/topics': (context) => Topics(accessToken: token ?? ''),
        '/home': (context) => Home(accessToken: token ?? '', repositories: [],selectedTopics: selectedTopics ?? [],),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  final String token;
  final List<String> selectedTopics;

  const SplashScreen({Key? key, required this.token, required this.selectedTopics}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _fetchReposAndNavigate();
  }

  Future<void> _fetchReposAndNavigate() async {
    try {
      final repos = await fetchRepositoriesByTopics(
        accessToken: widget.token,
        selectedTopics: widget.selectedTopics,
        perPage: 15,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Home(accessToken: widget.token, repositories: repos,selectedTopics: widget.selectedTopics,),
        ),
      );
    } catch (e) {
      // If fetching fails, fallback to Topics page to reselect topics
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Topics(accessToken: widget.token),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
