import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/components/button_filled.dart';
import 'package:flutter_application_gitgud/pages/home.dart';

import 'package:flutter_application_gitgud/utils/colors.dart';
import 'package:flutter_application_gitgud/utils/github_api.dart';

import '../components/textfield_outline.dart';
import '../components/topic_grid_item.dart';
import '../utils/grid_data.dart';

class Topics extends StatefulWidget {
  final String accessToken;
  const Topics({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 56.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Topics', style: TextStyle(color: customGray)),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Pick the topics that you want to explore to personalize your GitGud feed. You can add more later.',
              style: TextStyle(fontSize: 16, color: customGray),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 12),
            Divider(color: customGray[100]),
            const SizedBox(height: 12),
            const CustomOutlinedTextField(hintText: 'Search'),
            const SizedBox(height: 12),

            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: buttonHeight + 16),
                    child: GridView.builder(
                      itemCount: topics.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 0.85,
                          ),
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        final isSelected = selectedIndices.contains(index);

                        return TopicGridItem(
                          label: topic['label']!,
                          iconPath: topic['icon']!,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedIndices.remove(index);
                              } else {
                                selectedIndices.add(index);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      minimum: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8,
                        ),
                        child: SizedBox(
                          height: buttonHeight,
                          child: CustomFilledButton(
                            text: 'Next',
                            onPressed: () async {
                              final selectedTopics =
                                  selectedIndices
                                      .map((index) => topics[index]['label']!)
                                      .toList();

                              if (selectedTopics.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please select at least one topic',
                                    ),
                                  ),
                                );
                                return;
                              }

                              // Show loading indicator while fetching
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder:
                                    (_) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              );

                              try {
                                final repos = await fetchRepositoriesByTopics(
                                  accessToken: widget.accessToken,
                                  selectedTopics: selectedTopics,
                                  perPage: 15,
                                );

                                Navigator.pop(context); // Remove loading dialog

                                // Navigate to SkillLevel or your feed page with repos
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => Home(
                                          accessToken: widget.accessToken,
                                          repositories: repos,
                                        ),
                                  ),
                                );
                              } catch (e) {
                                Navigator.pop(context); // Remove loading dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Failed to fetch repositories: $e',
                                    ),
                                  ),
                                );
                              }
                            },
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
      ),
    );
  }
}
