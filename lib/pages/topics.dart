import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/components/button_filled.dart';
import 'package:flutter_application_gitgud/pages/skill_level.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';

import '../components/textfield_outline.dart';
import '../components/topic_grid_item.dart';
import '../utils/grid_data.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // disables the glow effect
  }
} //needs work

class Topics extends StatefulWidget {
  const Topics({super.key});

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
                    child: ScrollConfiguration(
                      behavior: NoGlowScrollBehavior(),
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
                            onPressed: () {
                              // You can use selectedIndices here to get selected topics
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SkillLevel(),
                                ),
                              );
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
