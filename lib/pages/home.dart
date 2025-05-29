import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';

/*class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
      ),
    );
  }
} */

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'GitHub Cards Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: customWhite,
        cardColor: Color(0xFF161B22),
      ),
      home: GitHubCardsScreen(),
    );
  }
}

class GitHubCardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              RepositoryCard(),
              SizedBox(height: 16),
              LobeChat(),
              SizedBox(height: 16),
              RepositoryCard(),
              SizedBox(height: 16),
              GitHubUniverseCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class RepositoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.folder_outlined, color: Colors.grey, size: 20),
                SizedBox(width: 8),
                Text(
                  'mindsdb / ',
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                ),
                Text(
                  'mindsdb',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Icon(Icons.star_border, color: Colors.grey, size: 20),
                SizedBox(width: 4),
                Text(
                  '29.5k',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "AI's query engine - Platform for building AI that can answer questions over large scale federated data. - The only MCP Server you'll ever need.",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTag('ai', Colors.blue[700]!),
                _buildTag('mcp', Colors.purple[700]!),
                _buildTag('databases', Colors.blue[700]!),
                _buildTag('agi', Colors.green[700]!),
                _buildTag('agents', Colors.orange[700]!),
                _buildTag('rag', Colors.red[700]!),
                _buildTag('artificial-intelligence', Colors.blue[700]!),
                _buildTag('llms', Colors.indigo[700]!),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Updated 18 hours ago',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                Spacer(),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  'Python',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.grey[500], size: 18),
                SizedBox(width: 16),
                Icon(Icons.chat_bubble_outline, color: Colors.grey[500], size: 18),
                SizedBox(width: 16),
                Icon(Icons.share, color: Colors.grey[500], size: 18),
                Spacer(),
                Icon(Icons.bookmark_border, color: Colors.grey[500], size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4), width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color.withOpacity(0.9),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class LobeChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF9B59B6),
                  Color(0xFFE74C3C),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '🤖',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'LobeChat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Built for you\nthe Super Individual',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.arrow_upward, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Icon(Icons.circle, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Icon(Icons.apps, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Icon(Icons.extension, color: Colors.white, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  bottom: 20,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 4),
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: index % 2 == 0 
                                          ? Colors.blue[700]?.withOpacity(0.3)
                                          : Colors.grey[700]?.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GitHubUniverseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1117),
              Color(0xFF1F2937),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF10B981),
                    Color(0xFF3B82F6),
                    Color(0xFF8B5CF6),
                    Color(0xFFEF4444),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      'Open Source Zone',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Big stage. Bright lights.',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          'Free booth. Apply to show',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          'off your open source',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          'project at GitHub Universe.',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DEADLINE TO APPLY',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'JULY 31, 2025',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.code, color: Colors.white, size: 20),
                        SizedBox(width: 4),
                        Text(
                          '25',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.purple[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '🎭',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.campaign, color: Colors.blue[400], size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Call for projects',
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Share Your Open Source Story at GitHub Universe',
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Be part of the Open Source Zone and showcase your project to thousands of developers, contributors, and industry leaders in San Francisco. Whether you\'re building solo or with a team, this is your chance to demo live, spark connections, and grow your impact.',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'What\'s included:',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildBulletPoint('Free GitHub Universe ticket for you and a friend'),
                  _buildBulletPoint('Dedicated demo space for your project'),
                  _buildBulletPoint('Chances to swap stories, ideas, and maybe stickers with fellow contributors, big tech, industry heavyweights, and more ✨'),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.favorite_border, color: Colors.grey[500], size: 18),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline, color: Colors.grey[500], size: 18),
                      SizedBox(width: 16),
                      Icon(Icons.share, color: Colors.grey[500], size: 18),
                      Spacer(),
                      Icon(Icons.bookmark_border, color: Colors.grey[500], size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}