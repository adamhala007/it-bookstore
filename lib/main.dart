import 'package:flutter/material.dart';
import 'package:it_bookstore/app/di.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(ItBookstoreApp());
}
