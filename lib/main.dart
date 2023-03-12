import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:it_bookstore/app/di.dart';

import 'app/app.dart';
import 'resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [slovakLocal],
      path: assetsPathLocalisations,
      child: ItBookstoreApp()));
}
