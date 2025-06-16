import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../utils/gemini_service.dart'; 

class RepositoryCard extends StatefulWidget {
  final Map<String, dynamic> repository;
  final String? githubToken; 

  const RepositoryCard({Key? key, required this.repository, this.githubToken})
    : super(key: key);

  @override
  State<RepositoryCard> createState() => _RepositoryCardState();
}

class _RepositoryCardState extends State<RepositoryCard> {
  String? _summary;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _generateSummary();
  }

  Future<void> _generateSummary() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repo = widget.repository;
      final owner = repo['owner']['login'] as String;
      final name = repo['name'] as String;
      String? promptText = repo['description'];

      // If description is missing or empty, fetch README content
      if (promptText == null || promptText.trim().isEmpty) {
        promptText = await _fetchReadme(owner, name, widget.githubToken);
      }

      if (promptText == null || promptText.trim().isEmpty) {
        setState(() {
          _summary = 'No description or README available.';
          _isLoading = false;
        });
        return;
      }

      // Optional: truncate promptText to limit token usage
      if (promptText.length > 1000) {
        promptText = promptText.substring(0, 1000);
      }

      final prompt = 'Summarize this GitHub repository content:\n$promptText';
      final summary = await GeminiService.generateSummary(prompt);

      if (mounted) {
        setState(() {
          _summary = summary ?? 'No summary available.';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to generate summary.';
          _isLoading = false;
        });
      }
    }
  }

  Future<String?> _fetchReadme(String owner, String repo, String? token) async {
    final url = Uri.parse('https://api.github.com/repos/$owner/$repo/readme');

    final headers = {
      'Accept': 'application/vnd.github+json',
      if (token != null) 'Authorization': 'Bearer $token',
      'X-GitHub-Api-Version': '2022-11-28',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final encodedContent = data['content'] as String?;
      if (encodedContent != null) {
        final decodedBytes = base64.decode(encodedContent);
        return utf8.decode(decodedBytes);
      }
    } else {
      print('Failed to fetch README: ${response.statusCode}');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final repo = widget.repository;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _launchURL(repo['html_url']),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(repo),
              const SizedBox(height: 8),
              _buildDescription(repo),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else if (_summary != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _summary!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              _buildLanguageAndStats(repo),
              const SizedBox(height: 8),
              _buildFooter(repo),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> repo) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(repo['owner']['avatar_url'] ?? ''),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repo['owner']['login'] ?? '',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                repo['name'] ?? 'No name',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (repo['private'] == true)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Private',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
      ],
    );
  }

  Widget _buildDescription(Map<String, dynamic> repo) {
    final description = repo['description'];
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      description,
      style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildLanguageAndStats(Map<String, dynamic> repo) {
    return Row(
      children: [
        if (repo['language'] != null) ...[
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: _getLanguageColor(repo['language']),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            repo['language'],
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(width: 16),
        ],
        Icon(Icons.star_border, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          _formatNumber(repo['stargazers_count'] ?? 0),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(width: 16),
        Icon(Icons.call_split, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          _formatNumber(repo['forks_count'] ?? 0),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildFooter(Map<String, dynamic> repo) {
    final updatedAt = repo['updated_at'];
    if (updatedAt == null) return const SizedBox.shrink();

    return Text(
      'Updated ${_formatDate(updatedAt)}',
      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
    );
  }

  Color _getLanguageColor(String? language) {
    final colors = {
      'JavaScript': Colors.yellow[700]!,
      'Python': Colors.blue[600]!,
      'Java': Colors.orange[700]!,
      'TypeScript': Colors.blue[800]!,
      'Go': Colors.cyan[600]!,
      'Rust': Colors.brown[600]!,
      'C++': Colors.pink[600]!,
      'C': Colors.grey[700]!,
      'Swift': Colors.orange[500]!,
      'Kotlin': Colors.purple[600]!,
      'Dart': Colors.blue[400]!,
      'PHP': Colors.indigo[600]!,
      'Ruby': Colors.red[600]!,
      'C#': Colors.green[600]!,
    };
    return colors[language] ?? Colors.grey[400]!;
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Recently';
    }
  }

  void _launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    }
  }
}
