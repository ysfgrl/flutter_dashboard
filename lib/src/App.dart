
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/src/AppState.dart';
import 'package:flutter_dashboard/src/constants.dart';
import 'package:flutter_dashboard/src/BasePage.dart';
import 'package:flutter_dashboard/src/pages/Home.dart';
import 'package:flutter_dashboard/src/pages/LoginPage.dart';
import 'package:flutter_dashboard/src/pages/NotFoundPage.dart';
import 'package:flutter_dashboard/src/pages/RegisterPage.dart';
import 'package:flutter_dashboard/src/pages/user_datatable.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.light;
  ColorSeed colorSelected = ColorSeed.blue;

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return SchedulerBinding.instance.window.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleMaterialVersionChange() {
    setState(() {
      useMaterial3 = !useMaterial3;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: Builder(
        builder: (BuildContext context) {
          return VRouter(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Dashboard',
            localizationsDelegates:  context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode:themeMode,
            theme: ThemeData(
              colorSchemeSeed: colorSelected.color,
              useMaterial3: useMaterial3,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              colorSchemeSeed: colorSelected.color,
              useMaterial3: useMaterial3,
              brightness: Brightness.dark,
            ),
            routes: [
              VGuard(
                stackedRoutes: [
                  VRouteRedirector(path: "/", redirectTo: "/home"),
                  VNester(path: "/",
                      widgetBuilder: (child) => BasePage(body: child),
                      nestedRoutes: [
                        VWidget(path: "/home", widget: Home()),
                        VWidget(path: "/NotFound", widget: NotFoundPage()),
                        VWidget(path: "/mongo/user_datatable", widget: UserDatatable()),

                      ]
                  )
                ]
              ),
              VWidget(path: "/login", widget: LoginPage()),
              VWidget(path: "/register", widget: RegisterPage()),
              VRouteRedirector(path: '*', redirectTo: '/NotFound'),
            ],
          );
        },
      ),
    );
  }
}