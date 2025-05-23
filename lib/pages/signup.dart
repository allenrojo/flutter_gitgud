import 'package:flutter/material.dart';

import '../components/button_filled.dart';
import '../components/text_outline.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

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

            const SizedBox(height: 40),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start, 
                children: [
                  Text(
                    'Sign up for GitGud',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 110, 116, 145),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8), // Space between texts or widgets
                  Text(
                    'Create your account to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 110, 116, 145),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Add more widgets here if needed
                ],
              ),
            ),
            const SizedBox(height: 40),
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
          ],
        ),
      ),
    );
  }
}
