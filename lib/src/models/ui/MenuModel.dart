
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuModel {
  Text label;
  Icon? icon;
  Icon? iconUrl;
  String tooltip = "";
  String route;
  int id;
  List<MenuModel> children;
  MenuModel({
    required this.label,
    this.icon,
    this.tooltip = "",
    this.route = "/home",
    this.id = 0,
    this.children = const []
  });

}
