import 'package:flutter/material.dart';

import 'package:flutter_application_gitgud/pages/login.dart';
import 'package:flutter_application_gitgud/pages/signup.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';
import 'package:flutter_application_gitgud/utils/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_application_gitgud/utils/auth_service.dart';

import '../components/button_filled.dart';
import '../components/button_icon.dart';
import '../components/button_outlined.dart';
import '../components/text_divider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Welcome()));
}

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Image.asset('assets/icon/brandmark.png'),
            ),
            CustomOutlinedButton(
              text: 'Log in',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
            const SizedBox(height: 8),
            CustomFilledButton(
              text: 'Sign up',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signup()),
                );
              },
            ),
            const SizedBox(height: 16),
            const DividerWithText(text: 'or'),
            const SizedBox(height: 16),

            CustomOutlinedIconButton(
              text: 'Continue with Github',
              iconPath: 'assets/icon/github.png',
              onPressed: () async {
                try {
                  final accessToken = await signInWithGitHub();
                  if (accessToken != null) {
                    await SecureStorage.saveToken(accessToken);
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Topics(accessToken: accessToken),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('GitHub sign-in failed')),
                    );
                  }
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
