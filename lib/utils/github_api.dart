import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchRepositoriesByTopics({
  required String accessToken,
  required List<String> selectedTopics,
  int perPage = 10,
  int page = 1,
}) async {
  final topicMap = {
    'Machine Learning': 'machine-learning',
    'Android Dev': 'android',
    'Dev Ops': 'devops',
    'Game Dev': 'game-development',
    'iOS Dev': 'ios',
    'Web Dev': 'web-development',
    'Data Science': 'data-science',
    'Cybersecurity': 'security',
    'Cloud Computing': 'cloud-computing',
    'Blockchain': 'blockchain',
    'AR/VR': 'ar-vr',
    'Robotics': 'robotics',
  };

  final List<Map<String, dynamic>> repos = [];

  for (final topic in selectedTopics) {
    final githubTopic = topicMap[topic] ?? topic.toLowerCase().replaceAll(' ', '-');
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


  final uniqueRepos = {for (var repo in repos) repo['id']: repo}.values.toList();

  // Sort by stars descending
  uniqueRepos.sort((a, b) => b['stargazers_count'].compareTo(a['stargazers_count']));

  return uniqueRepos;
}
