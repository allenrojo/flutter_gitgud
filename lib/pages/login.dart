import 'package:flutter/material.dart';

import '../components/button_filled.dart';
import '../components/textfield_outline.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Image.asset('assets/icon/brandmark.png'),
            ),



            CustomOutlinedTextField(hintText: 'Email or phone number'),
            const SizedBox(height: 12),
            CustomOutlinedTextField(hintText: 'Password', obscureText: true),
            const SizedBox(height: 12),
            CustomFilledButton(
              text: 'Log in',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Topics()),
                );
              },
            ),
          ]
        )
      ),
    );
  }
}
