import 'dart:ui';
import 'package:flutter/material.dart';

/**
 * ColorPicker contains all colors used in the app. Right now the app colors are fixed,
 * but this class makes it easy to implement different color modes - like dark mode
 */
class ColorPicker {

  Color getPrimary() {
    return Color(0xFFFFFFFF);
  }

  Color getPrimaryFont() {
    return Color(0xFF000000);
  }

  Color getStartPageColor() {
    return Colors.red;
  }

  Color getStartPageFontColor() {
    return Color(0xFFFFFFFF);
  }

  Color getRulesPageColor() {
    return Colors.green;
  }

  Color getRulesPageFontColor() {
    return Color(0xFFFFFFFF);
  }

  Color getSettingsPageColor() {
    return Colors.blue;
  }

  Color getSettingsPageFontColor() {
    return Color(0xFFFFFFFF);
  }

  Color getLeaderboardColor(){
    return Colors.purple[800];
  }

  Color getLeaderboardFontColor(){
    return Colors.white;
  }

  Color getDisabledColor() {
    return Color(0xFFcecece);
  }

}