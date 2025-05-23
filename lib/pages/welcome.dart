import 'package:flutter/material.dart';

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
            Image.asset('assets/icon/brandmark.png'),

            const SizedBox(height: 40),

            // Reusable outlined button
            CustomOutlinedButton(
              text: 'Log in',
              onPressed: () {
                print('Log in pressed!');
              },
            ),

            const SizedBox(height: 8),

            // Reusable elevated button
            CustomElevatedButton(
              text: 'Sign up',
              onPressed: () {
                print('Sign up pressed!');
              },
            ),

            const SizedBox(height: 16),

            // Divider with "or"
            const DividerWithText(text: 'or'),

            const SizedBox(height: 16),

            // Continue with Github
            CustomOutlinedIconButton(
              text: 'Continue with Github',
              iconPath: 'assets/icon/github.png',
              onPressed: () {
                print('Continue with Github pressed!');
              },
            ),

            const SizedBox(height: 8),

            // Continue with Google
            CustomOutlinedIconButton(
              text: 'Continue with Google',
              iconPath: 'assets/icon/google.png',
              onPressed: () {
                print('Continue with Google pressed!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable outlined button
class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF6C63FF),
          side: const BorderSide(color: Color(0xFF6C63FF)),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text),
      ),
    );
  }
}

// Reusable elevated button
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text),
      ),
    );
  }
}

// Reusable outlined icon button
class CustomOutlinedIconButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  const CustomOutlinedIconButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(iconPath, width: 24, height: 24),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF6C63FF),
          side: const BorderSide(color: Color(0xFF6C63FF)),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

// Divider with centered text widget
class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[400])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(text, style: const TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Divider(color: Colors.grey[400])),
      ],
    );
  }
}
