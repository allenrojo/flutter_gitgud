import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryCard extends StatelessWidget {
  final Map<String, dynamic> repository;

  const RepositoryCard({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _launchURL(repository['html_url']),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 8),
              _buildDescription(),
              const SizedBox(height: 12),
              _buildLanguageAndStats(),
              const SizedBox(height: 8),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            repository['owner']['avatar_url'] ?? '',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repository['owner']['login'] ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                repository['name'] ?? 'No name',
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
        if (repository['private'] == true)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Private',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDescription() {
    final description = repository['description'];
    if (description == null || description.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Text(
      description,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildLanguageAndStats() {
    return Row(
      children: [
        if (repository['language'] != null) ...[
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: _getLanguageColor(repository['language']),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            repository['language'],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
        ],
        Icon(
          Icons.star_border,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          _formatNumber(repository['stargazers_count'] ?? 0),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.call_split,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          _formatNumber(repository['forks_count'] ?? 0),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    final updatedAt = repository['updated_at'];
    if (updatedAt == null) return const SizedBox.shrink();
    
    return Text(
      'Updated ${_formatDate(updatedAt)}',
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey[500],
      ),
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
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
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
