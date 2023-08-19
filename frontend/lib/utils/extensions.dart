import 'dart:ui';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  Color hexToColor() {
    return Color(int.parse('0xFF$this'));
  }
}
