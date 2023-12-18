// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

// NavigationRail shows if the screen width is greater or equal to
// narrowScreenWidthThreshold; otherwise, NavigationBar is used for navigation.
const double narrowScreenWidthThreshold = 450;

const double mediumWidthBreakpoint = 1000;
const double largeWidthBreakpoint = 1500;

const double transitionLength = 500;
const double widthConstraint = 450;
const smallSpacing = 10.0;

const colDivider = SizedBox(height: 10);
const double cardWidth = 115;

const List<Color> colorList= [
  Color(0xFF9A3636),
  Color(0xFF4CA8E3),
  Color(0xFFF1CE5F),
  Color(0xFF9147EF),
  Color(0xFF4C3072),
  Color(0xFF347487),
  Color(0xFFD67D47),
  Color(0xFF4AA4A8),
  Color(0xFF72AF61),
  Color(0xFF4CA8E3),
  Color(0xFF8B8C8F),
  Color(0xFF4E729A),
] ;


enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

enum ScreenSelected {
  tvScreen(0),
  rdScreen(1),
  musicMp3Screen(2),
  musicClipScreen(3),
  kidsScreen(4),
  contactScreen(5),
  aboutScreen(6),
  filScreen(7),
  surveyScreen(8);

  const ScreenSelected(this.value);
  final int value;
}


class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(secondary: Colors.red),
    disabledColor: Colors.grey.shade400,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(secondary: Colors.red),
    disabledColor: Colors.grey.shade400,
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}


class LocaleTileMenuItem extends StatelessWidget {
  const LocaleTileMenuItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.locale,
    this.bgColor = Colors.transparent,
    this.textStyle
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Locale locale;
  final Color? bgColor;
  final TextStyle? textStyle;

  bool isSelected(BuildContext context) => locale == context.locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 40, top: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border:
        isSelected(context) ? Border.all(color: Colors.blueAccent) : null,
      ),
      child: ListTile(
          dense: true,
          // isThreeLine: true,
          leading: Image.asset("assets/flag_"+locale.languageCode+".png"),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          subtitle: Text(
            textAlign: TextAlign.center,
            subtitle,
            style: textStyle,
          ),
          trailing: isSelected(context)
          ?
          Icon(Icons.check_circle_outlined, color: textStyle != null ? textStyle!.color: Colors.green,):
          Text(""),
          onTap: () async {
            await context.setLocale(locale); //BuildContext extension method
            // ApiService.mediaTypesMap.clear();
            Navigator.pop(context);
            // Navigator.pushNamed(context, "/home");
          }),
    );
  }
}

showSnackBar(BuildContext context, String msg) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 600),
      ),
    );
  });
}


