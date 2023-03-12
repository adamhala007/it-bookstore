import 'package:flutter/material.dart';
import 'package:it_bookstore/app/di.dart';
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
        initBookStoreModule();
        return MaterialPageRoute(builder: (_) => BooksView());
      case Routes.bookDetailsRoute:
        initBookDetailModule();
        return MaterialPageRoute(
            builder: (_) => BookDetailsView(
                  routeSettings: routeSettings,
                ));
      default:
        initBookStoreModule();
        return MaterialPageRoute(builder: (_) => BooksView());
    }
  }
}
