import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_application_gitgud/pages/topics.dart';
import 'package:flutter_application_gitgud/utils/secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../components/button_icon.dart';


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _handleGitHubSignIn() async {
    setState(() => _isLoading = true);
    
    try {
      // 1. Create GitHub provider instance
      final githubProvider = GithubAuthProvider();

      // 2. Add required scopes
      githubProvider.addScope('repo,read:org');
      
      // 3. Sign in with Firebase using GitHub provider
      final UserCredential userCredential = 
        await _auth.signInWithProvider(githubProvider);

      // 4. Get GitHub access token from Firebase credentials
      final accessToken = userCredential.credential?.accessToken;
      
      if (accessToken != null && mounted) {
        // 5. Store token securely (if still needed for GitHub API calls)
        await SecureStorage.saveGitHubToken(accessToken);
        
        // 6. Navigate to topics page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Topics(accessToken: accessToken),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

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
            if (!_isLoading) ...[
              CustomOutlinedIconButton(
                text: 'Login with Github',
                iconPath: 'assets/icon/github.png',
                onPressed: _handleGitHubSignIn,
              ),
            ],
            if (_isLoading) ...[
              const SizedBox(height: 32),
              const Center(child: CircularProgressIndicator()),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
