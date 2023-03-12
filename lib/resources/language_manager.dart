import 'package:flutter/material.dart';

enum LanguageType { slovak, english }

const String slovak = 'sk';
const String english = 'en';
const String assetsPathLocalisations = 'assets/translations';
const Locale slovakLocal = Locale("sk", "SK");
const Locale englishLocal = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.slovak:
        return slovak;
      case LanguageType.english:
        return english;
    }
  }
}
