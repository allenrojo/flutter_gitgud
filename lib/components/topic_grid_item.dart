import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TopicGridItem extends StatefulWidget {
  final String label;
  final String iconPath;

  const TopicGridItem({
    Key? key,
    required this.label,
    required this.iconPath,
  }) : super(key: key);

  @override
  State<TopicGridItem> createState() => _TopicGridItemState();
}

class _TopicGridItemState extends State<TopicGridItem> {
  bool _isSelected = false;

  void _toggleSelected() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: _isSelected ? customPurple[200]! : const Color(0xFFE8EAF6),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.iconPath,
                fit: BoxFit.contain,
                width: 40,
                height: 40,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: customGray,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
