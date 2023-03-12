import 'package:flutter/material.dart';

enum LanguageType { slovak }

const String slovak = 'sk';
const String assetsPathLocalisations = 'assets/translations';
const Locale slovakLocal = Locale("sk", "SK");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.slovak:
        return slovak;
    }
  }
}
