
import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dashboard/src/App.dart';
import 'package:flutter_dashboard/src/models/ui/MyLocale.dart';

Future<String> loadLocales() async {
  return await rootBundle.loadString('assets/locales.json');
}

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  // runApp(const App());

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);
  String content = await loadLocales();
  List<dynamic> list = json.decode(content);
  List<MyLocale> localeList = list.map((l) => MyLocale.fromJson(l)).toList();
  runApp(EasyLocalization(
      supportedLocales: localeList.map((e) => Locale(e.languageCode, e.countryCode)).toList(),
      path: 'assets/translation',
      child: const App(),
      startLocale: const Locale('en', 'US'),
      saveLocale: true,
      useOnlyLangCode: true,
      assetLoader: YamlAssetLoader()
  ));
}



