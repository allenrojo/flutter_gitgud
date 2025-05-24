import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: customGray[100])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(
              color: customGray,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize ?? 16,
            ),
          ),
        ),
        Expanded(child: Divider(color: customGray[100])),
      ],
    );
  }
}
