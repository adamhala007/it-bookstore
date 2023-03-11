import 'package:flutter/material.dart';
import 'package:it_bookstore/resources/routes_manager.dart';
import 'package:it_bookstore/resources/theme_manager.dart';

class ItBookstoreApp extends StatefulWidget {
  const ItBookstoreApp._internal();
  static const ItBookstoreApp instance = ItBookstoreApp._internal();

  factory ItBookstoreApp() => instance;

  @override
  State<ItBookstoreApp> createState() => _ItBookstoreAppState();
}

class _ItBookstoreAppState extends State<ItBookstoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.booksRoute,
      theme: getApplicationTheme(),
    );
  }
}
