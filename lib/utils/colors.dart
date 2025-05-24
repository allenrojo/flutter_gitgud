import 'package:flutter/material.dart';

const Map<int, Color> purpleShades = {
  50: Color(0xFFE6E5FF),
  100: Color(0xFFBFBFFF),
  200: Color(0xFF9998FF),
  300: Color(0xFF726FFF),
  400: Color(0xFF564DFF),
  500: Color(0xFF6C63FF), // Your primary color
  600: Color(0xFF5A53E6),
  700: Color(0xFF4A43CC),
  800: Color(0xFF3A33B3),
  900: Color(0xFF2A2399),
};
const MaterialColor customPurple = MaterialColor(0xFF6C63FF, purpleShades);

const Map<int, Color> grayShades = {
  50: Color(0xFFE6E8F0),
  100: Color(0xFFBFC4D1),
  200: Color(0xFF999EB3),
  300: Color(0xFF727A95),
  400: Color(0xFF565F82),
  500: Color(0xFF6E7491), // Your primary color
  600: Color(0xFF5B627A),
  700: Color(0xFF4B5166),
  800: Color(0xFF3A4051),
  900: Color(0xFF292E3B),
};

const MaterialColor customGray = MaterialColor(0xFF6E7491, grayShades);