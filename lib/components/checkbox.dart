import 'package:flutter/material.dart';
import 'package:flutter_application_gitgud/utils/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          side: MaterialStateBorderSide.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return BorderSide(width: 2.0, color: customPurple);
            }
            return BorderSide(width: 1.0, color: Colors.grey);
          }),
          activeColor: const Color(0xFF6C63FF),
          
        ),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color:customGray),
          ),
        ),
      ],
    );
  }
}
