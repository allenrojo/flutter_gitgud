import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';

import '../components/button_filled.dart';
import '../components/checkbox.dart';
import '../components/textfield_outline.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool agreeTerms = false;

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

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Sign up for GitGud',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: customGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'GitGud is totally free to use. Sign up using your email address or phone number below to get started.',
                    style: TextStyle(
                      fontSize: 16,
                      color: customGray,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            CustomOutlinedTextField(hintText: 'Username'),

            const SizedBox(height: 12),

            CustomOutlinedTextField(hintText: 'Email or phone number'),

            const SizedBox(height: 12),

            CustomOutlinedTextField(hintText: 'Password', obscureText: true),

            const SizedBox(height: 12),

            /*CustomFilledButton(
              text: 'Log in',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Topics()),
                );
              },
            ),*/
            
            CustomCheckbox(
              value: agreeTerms,
              label: 'I agree to the terms and conditions',
              onChanged: (bool? newValue) {
                setState(() {
                  agreeTerms = newValue ?? false;
                });
              },
            ),
            CustomCheckbox(
              value: agreeTerms,
              label: 'I agree to the terms and conditions',
              onChanged: (bool? newValue) {
                setState(() {
                  agreeTerms = newValue ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
