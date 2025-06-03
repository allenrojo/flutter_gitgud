import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/pages/topics.dart';
import 'package:flutter_application_gitgud/utils/github_api.dart';
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
        title: const Text(
          'GitGud',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Topics(accessToken: widget.accessToken),
                ),
              );
            },
          ),
        ],
      ),
      body: _repositories.isEmpty && _isLoading
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
