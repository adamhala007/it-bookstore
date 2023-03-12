import 'package:it_bookstore/data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return emptyString;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return zero;
    } else {
      return this!;
    }
  }
}

extension NonNullList on List? {
  List orEmpty() {
    if (this == null) {
      return emptyList;
    } else {
      return this!;
    }
  }
}
