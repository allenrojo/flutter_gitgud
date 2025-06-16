import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchRepositoriesByTopics({
  required String accessToken,
  required List<String> selectedTopics,
  int perPage = 10,
  int page = 1,
}) async {
  final topicMap = {
    '3D': '3d',
    'Ajax': 'ajax',
    'Algorithm': 'algorithm',
    'Amp': 'amp',
    'Android': 'android',
    'Angular': 'angular',
    'Ansible': 'ansible',
    'API': 'api',
    'Arduino': 'arduino',
    'ASP.NET': 'asp-net',
    'Awesome Lists': 'awesome-lists',
    'Amazon Web Services': 'amazon-web-services',
    'Azure': 'azure',
    'Babel': 'babel',
    'Bash': 'bash',
    'Bitcoin': 'bitcoin',
    'Bootstrap': 'bootstrap',
    'Bot': 'bot',
    'C': 'c',
    'Chrome': 'chrome',
    'Chrome extension': 'chrome-extension',
    'Command‑line interface': 'command-line-interface',
    'Clojure': 'clojure',
    'Code quality': 'code-quality',
    'Code review': 'code-review',
    'Compiler': 'compiler',
    'Continuous integration': 'continuous-integration',
    'C++': 'c-plus-plus',
    'Cryptocurrency': 'cryptocurrency',
    'Crystal': 'crystal',
    'C#': 'c-sharp',
    'CSS': 'css',
    'Data structures': 'data-structures',
    'Data visualization': 'data-visualization',
    'Database': 'database',
    'Deep learning': 'deep-learning',
    'Dependency management': 'dependency-management',
    'Deployment': 'deployment',
    'Django': 'django',
    'Docker': 'docker',
    'Documentation': 'documentation',
    '.NET': 'dotnet',
    'Electron': 'electron',
    'Elixir': 'elixir',
    'Emacs': 'emacs',
    'Ember': 'ember',
    'Emoji': 'emoji',
    'Emulator': 'emulator',
    'ESLint': 'eslint',
    'Ethereum': 'ethereum',
    'Express': 'express',
    'Firebase': 'firebase',
    'Firefox': 'firefox',
    'Flask': 'flask',
    'Font': 'font',
    'Framework': 'framework',
    'Front end': 'front-end',
    'Game engine': 'game-engine',
    'Git': 'git',
    'GitHub API': 'github-api',
    'Go': 'go',
    'Google': 'google',
    'Gradle': 'gradle',
    'GraphQL': 'graphql',
    'Gulp': 'gulp',
    'Hacktoberfest': 'hacktoberfest',
    'Haskell': 'haskell',
    'Homebrew': 'homebrew',
    'Homebridge': 'homebridge',
    'HTML': 'html',
    'HTTP': 'http',
    'Icon font': 'icon-font',
    'iOS': 'ios',
    'IPFS': 'ipfs',
    'Java': 'java',
    'JavaScript': 'javascript',
    'Jekyll': 'jekyll',
    'jQuery': 'jquery',
    'JSON': 'json',
    'Julia': 'julia',
    'Jupyter Notebook': 'jupyter-notebook',
    'Koa': 'koa',
    'Kotlin': 'kotlin',
    'Kubernetes': 'kubernetes',
    'Laravel': 'laravel',
    'LaTeX': 'latex',
    'Library': 'library',
    'Linux': 'linux',
    'Localization (l10n)': 'localization-l10n',
    'Lua': 'lua',
    'Machine learning': 'machine-learning',
    'macOS': 'macos',
    'Markdown': 'markdown',
    'Mastodon': 'mastodon',
    'Material Design': 'material-design',
    'MATLAB': 'matlab',
    'Maven': 'maven',
    'Minecraft': 'minecraft',
    'Mobile': 'mobile',
    'Monero': 'monero',
    'MongoDB': 'mongodb',
    'Mongoose': 'mongoose',
    'Monitoring': 'monitoring',
    'MvvmCross': 'mvvmcross',
    'MySQL': 'mysql',
    'NativeScript': 'nativescript',
    'Nim': 'nim',
    'Natural language processing': 'natural-language-processing',
    'Node.js': 'node-js',
    'NoSQL': 'nosql',
    'npm': 'npm',
    'Objective‑C': 'objective-c',
    'OpenGL': 'opengl',
    'Operating system': 'operating-system',
    'P2P': 'p2p',
    'Package manager': 'package-manager',
    'Parsing': 'parsing',
    'Perl': 'perl',
    'Phaser': 'phaser',
    'PHP': 'php',
    'PICO‑8': 'pico-8',
    'Pixel Art': 'pixel-art',
    'PostgreSQL': 'postgresql',
    'Project management': 'project-management',
    'Publishing': 'publishing',
    'PWA': 'pwa',
    'Python': 'python',
    'Qt': 'qt',
    'R': 'r',
    'Rails': 'rails',
    'Raspberry Pi': 'raspberry-pi',
    'Ratchet': 'ratchet',
    'React': 'react',
    'React Native': 'react-native',
    'ReactiveUI': 'reactiveui',
    'Redux': 'redux',
    'REST API': 'rest-api',
    'Ruby': 'ruby',
    'Rust': 'rust',
    'Sass': 'sass',
    'Scala': 'scala',
    'scikit‑learn': 'scikit-learn',
    'Software‑defined networking': 'software-defined-networking',
    'Security': 'security',
    'Server': 'server',
    'Serverless': 'serverless',
    'Shell': 'shell',
    'Sketch': 'sketch',
    'SpaceVim': 'spacevim',
    'Spring Boot': 'spring-boot',
    'SQL': 'sql',
    'Storybook': 'storybook',
    'Support': 'support',
    'Swift': 'swift',
    'Symfony': 'symfony',
    'Telegram': 'telegram',
    'TensorFlow': 'tensorflow',
    'Terminal': 'terminal',
    'Terraform': 'terraform',
    'Testing': 'testing',
    'X (Twitter)': 'x-twitter',
    'TypeScript': 'typescript',
    'Ubuntu': 'ubuntu',
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
