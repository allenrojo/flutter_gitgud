import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TopicGridItem extends StatelessWidget {
  final String label;
  final String iconPath;
  final double avatarRadius;
  final double fontSize;
  final bool isSelected;
  final VoidCallback? onTap;

  const TopicGridItem({
    Key? key,
    required this.label,
    required this.iconPath,
    this.avatarRadius = 32,
    this.fontSize = 14,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? customPurple[200]! : Colors.transparent,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: const Color(0xFFE8EAF6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  width: avatarRadius,
                  height: avatarRadius,
                ),
              ),
            ),
          ),
          SizedBox(height: avatarRadius * 0.25),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: customGray,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
