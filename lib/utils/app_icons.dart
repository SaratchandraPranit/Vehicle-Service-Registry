import 'package:flutter/material.dart';

/// A utility class that uses text-based icons instead of Material Icons
/// This approach is more compatible with web browsers
class AppIcons {
  // Define static methods that return text-based icons
  static Widget logout({Color? color, double size = 24.0}) {
    return Text(
      "⎋", // Unicode exit symbol
      style: TextStyle(color: color, fontSize: size, fontFamily: 'Roboto'),
    );
  }

  static Widget edit({Color? color, double size = 24.0}) {
    return Text(
      "✎", // Unicode edit/pencil symbol
      style: TextStyle(color: color, fontSize: size, fontFamily: 'Roboto'),
    );
  }

  static Widget delete({Color? color, double size = 24.0}) {
    return Text(
      "🗑", // Unicode trash/delete symbol
      style: TextStyle(color: color, fontSize: size, fontFamily: 'Roboto'),
    );
  }

  static Widget add({Color? color, double size = 24.0}) {
    return Text(
      "+", // Simple plus sign
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget back({Color? color, double size = 24.0}) {
    // Use a text-based back arrow for better web compatibility
    return Text(
      "←", // Unicode left arrow
      style: TextStyle(
        color: color,
        fontSize: size * 1.5, // Make it slightly larger
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
