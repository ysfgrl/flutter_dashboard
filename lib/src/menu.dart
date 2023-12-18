
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/src/models/ui/MenuModel.dart';
import 'package:flutter_dashboard/src/models/ui/MyLocale.dart';

class DrawerMenu extends StatefulWidget {
  final Function(MenuModel, int) onClick;
  final List<MenuModel> menuList;
  const DrawerMenu({super.key,required this.menuList, required this.onClick});

  @override
  State createState() => _MenuState();

}


class _MenuState extends State<DrawerMenu> {
  late MenuModel selected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFE2E2E2),
      child: ListView(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
              ),
              child: Text(""),
            ),
          ),
          ...widget.menuList.map((element) {
            if(element.children.isEmpty){
              return ListTile(
                leading: element.icon,
                title: element.label,
                onTap: () {
                  selected = element;
                  widget.onClick(element, widget.menuList.indexOf(element));
                },
              );
            }else{
              return ExpansionTile(
                leading: element.icon,
                title: element.label,
                children: element.children.map((e) => Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: ListTile(
                    leading: e.icon,
                    title: e.label,
                    onTap: () {
                      selected = e;
                      widget.onClick(e, -1);
                    },
                  ),
                )).toList(),
              );
            }
          })
        ],
      ),
    );
  }
}
