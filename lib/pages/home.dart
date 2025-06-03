import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/pages/topics.dart'; // Import your Topics page

class Home extends StatefulWidget {
  final List<Map<String, dynamic>> repositories;
  final String accessToken; // Needed to navigate to Topics

  const Home({
    Key? key,
    this.repositories = const [],
    required this.accessToken,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    // Check if repositories list is empty and redirect
    if (widget.repositories.isEmpty) {
      // Delay navigation to ensure context is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Topics(accessToken: widget.accessToken),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Print repo info to terminal
    for (var repo in widget.repositories) {
      print('Repo: ${repo['name']} - Stars: ${repo['stargazers_count']}');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Your GitHub Feed')),
      body: Center(
        child: widget.repositories.isEmpty
            ? const CircularProgressIndicator() // While redirecting
            : ListView.builder(
                itemCount: widget.repositories.length,
                itemBuilder: (context, index) {
                  final repo = widget.repositories[index];
                  return ListTile(
                    title: Text(repo['name'] ?? 'No name'),
                    subtitle: Text('⭐ ${repo['stargazers_count'] ?? 0} stars'),
                  );
                },
              ),
      ),
    );
  }
}
