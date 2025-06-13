import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';
import 'package:flutter_application_gitgud/pages/welcome.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';
import 'package:flutter_application_gitgud/utils/github_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/repository_card.dart'; // Import your new card widget

class Home extends StatefulWidget {
  final List<Map<String, dynamic>> repositories;
  final String accessToken;
  final List<String> selectedTopics; // Add this to know which topics to fetch

  const Home({
    Key? key,
    this.repositories = const [],
    required this.accessToken,
    required this.selectedTopics,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Map<String, dynamic>> _repositories;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _repositories = widget.repositories;
  }

  Future<void> _refreshRepositories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final newRepos = await fetchRepositoriesByTopics(
        accessToken: widget.accessToken,
        selectedTopics: widget.selectedTopics,
        perPage: 15,
      );
      setState(() {
        _repositories = newRepos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh repositories: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 150,
        titleSpacing: 0,
        title: null,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: SizedBox(
          child: Center(child: Image.asset('assets/icon/brandmark.png',height:double.infinity, fit: BoxFit.fitHeight)),
          
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: customGray,),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body:
          _repositories.isEmpty && _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _refreshRepositories,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _repositories.length,
                  itemBuilder: (context, index) {
                    final repo = _repositories[index];
                    return RepositoryCard(repository: repo);
                  },
                ),
              ),
    );
  }
}
Future<void> logout(BuildContext context) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to logout?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              Navigator.of(context).pop(); // Dismiss the dialog first

              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('github_access_token'); // Clear token

              // Navigate to login screen
              Navigator.of(context).pushReplacementNamed('/welcome');
            },
          ),
        ],
      );
    },
  );
}

