import 'dart:convert';
import 'package:http/http.dart' as http;
import 'topic_data.dart';

Future<List<Map<String, dynamic>>> fetchRepositoriesByTopics({
  required String accessToken,
  required List<String> selectedTopics,
  int perPage = 10,
  int page = 1,
}) async {
   final Map<String, String> topicMap = {
    for (var topic in topics) topic['label']!: topic['apiName']!,
  };

  final List<Map<String, dynamic>> repos = [];

  for (final topic in selectedTopics) {
    final githubTopic =
        topicMap[topic] ?? topic.toLowerCase().replaceAll(' ', '-');
    final url = Uri.parse(
      'https://api.github.com/search/repositories?q=topic:$githubTopic&sort=stars&order=desc&per_page=$perPage',
    );

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      repos.addAll(List<Map<String, dynamic>>.from(data['items']));
    } else {
      print('Failed to fetch repos for topic $topic: ${response.statusCode}');
    }
  }

  final uniqueRepos =
      {for (var repo in repos) repo['id']: repo}.values.toList();

  // Sort by stars descending
  uniqueRepos.sort(
    (a, b) => b['stargazers_count'].compareTo(a['stargazers_count']),
  );

  return uniqueRepos;
}

Future<String?> fetchReadme(
  String owner,
  String repo,
  String? githubToken,
) async {
  final url = Uri.parse('https://api.github.com/repos/$owner/$repo/readme');

  final headers = {
    'Accept': 'application/vnd.github+json',
    if (githubToken != null) 'Authorization': 'Bearer $githubToken',
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
    print('Failed to fetch README: ${response.statusCode} ${response.body}');
  }

  return null;
}
