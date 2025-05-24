import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';

import '../components/textfield_outline.dart';

import '../components/topic_grid_item.dart';
import '../utils/topic_data.dart';

class Topics extends StatelessWidget {
  const Topics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Topics',
          style: TextStyle(color:customGray),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pick the topics that you want to explore to personalize your GitGud feed. You can add more later.',
              style: TextStyle(
                fontSize: 16,
                color: customGray,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 12),
            Divider(color: customGray[100]),
            SizedBox(height: 12),
            CustomOutlinedTextField(hintText: 'Search'),
            SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                itemCount: topics.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  return TopicGridItem(
                    label: topic['label']!,
                    iconPath: topic['icon']!,
                    
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
