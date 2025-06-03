/*import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/components/button_filled.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';

import '../components/topic_grid_item.dart';
import '../utils/grid_data.dart';
import '../pages/home.dart';

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

class SkillLevel extends StatefulWidget {
  const SkillLevel({super.key});

  @override
  State<SkillLevel> createState() => _SkillLevelState();
}

class _SkillLevelState extends State<SkillLevel> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 56.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Skill Level',
          style: TextStyle(color: customGray),
        ),
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
              'Pick the appropriate proficiency level to personalize your GitGud feed. You can add more later.',
              style: TextStyle(fontSize: 16, color: customGray),
              textAlign: TextAlign.left,
            ),
            
            const SizedBox(height: 12),

            Divider(color: customGray[100]),

            const SizedBox(height: 12),

            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(skill_level.length, (index) {
                    final topic = skill_level[index];
                    final isSelected = selectedIndex == index;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TopicGridItem(
                        label: topic['label']!,
                        iconPath: topic['icon']!,
                        avatarRadius: 48,
                        fontSize: 16,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),

            SafeArea(
              minimum: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                height: buttonHeight,
                width: double.infinity,
                child: CustomFilledButton(
                  text: 'Done',
                  onPressed: () {
                    if (selectedIndex != null) {
                      final selectedTopic = skill_level[selectedIndex!];
                      // Do something with selectedTopic if needed
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
