import 'dart:math';

class BookStoreUtil {
  static int? countMaxPage(String? total) {
    if (total == null) {
      return null;
    }
    int totalInt = int.tryParse(total) ?? 1;
    return max((totalInt / 10).ceil(), 1);
  }
}
