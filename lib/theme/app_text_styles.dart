import 'dart:ui';

import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle title() {
    return TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle titleGrid() {
    return TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.red);
  }
}
