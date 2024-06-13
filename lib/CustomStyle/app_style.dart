import 'package:flutter/material.dart';
// bu classta hazırlamıs oldugum custom stylerı tutuyorum.

class AppStyle {
  static const appBarGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(124,116,160, 1), // Açık renk
        Color.fromRGBO(64,55,126,1),    // Koyu renk
        Color.fromRGBO(124,116,160, 1), // Açık renk
      ],
      stops: [0.0, 0.5, 1.0],  // Renklerin dağılımını belirler
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );

  static final buttonColor = Color.fromRGBO(185, 192, 64, 1);
  static final cardColor = Color.fromRGBO(241, 245, 130, 1.0);

  static final backgroundColor=Color.fromRGBO(247,247,247,1);

}