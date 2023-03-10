import 'package:flutter/material.dart';
import 'package:it_bookstore/presentation/book_details/book_details.dart';
import 'package:it_bookstore/presentation/books/books.dart';

class Routes {
  static const String booksRoute = "/books";
  static const String bookDetailsRoute = "/bookDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.booksRoute:
        return MaterialPageRoute(builder: (_) => BooksView());
      case Routes.bookDetailsRoute:
        return MaterialPageRoute(builder: (_) => BookDetailsView());
      default:
        return MaterialPageRoute(builder: (_) => BooksView());
    }
  }
}
