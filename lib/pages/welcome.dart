import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/pages/login.dart';
import 'package:flutter_application_gitgud/pages/signup.dart';
import '../components/button_filled.dart';
import '../components/button_icon.dart';
import '../components/button_outlined.dart';
import '../components/text_divider.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),

            const SizedBox(height: 8),

            CustomOutlinedIconButton(
              text: 'Continue with Google',
              iconPath: 'assets/icon/google.png',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
