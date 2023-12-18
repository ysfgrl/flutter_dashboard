

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/src/AppState.dart';
import 'package:flutter_dashboard/src/menu.dart';
import 'package:flutter_dashboard/src/models/ui/MenuModel.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class BasePage extends StatelessWidget{

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget body;

  BasePage({required this.body});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder:(context, value, child) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 8.0,
            leadingWidth: 40,
            // leading: CircleAvatar(
            //     backgroundColor: Colors.transparent,
            //     child: Image.asset("assets/appicon.png")
            // ),
            title: const Text(
              "Golang Flutter",
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                tooltip: "Language",
                icon: Image.asset("assets/flag_${context.locale.languageCode}.png",height: 30,),
                onPressed: () {
                  // Navigator.pushNamed(context, "/Language");
                  //_localesEvent(context);
                },
              ),
            ],
          ),
          body: body,
          drawer: DrawerMenu(
            menuList: [
              MenuModel(
                  label: Text("Home"),
                  icon: Icon(Icons.home),
                  route: "/home"
              ),
              MenuModel(
                  label: Text("Mongo Db"),
                  icon: Icon(Icons.data_object),
                  children: [
                    MenuModel(
                        label: Text("Users"),
                        icon: Icon(Icons.account_circle_outlined),
                      route: "/mongo/user_datatable"
                    )
                  ]
              ),
              MenuModel(
                  label: Text("Elastic Search"),
                  icon: Icon(Icons.data_object),
                  children: [
                    MenuModel(
                        label: Text("User Posts"),
                        icon: Icon(Icons.share_rounded),
                        route: "/elastic/Users"
                    )
                  ]
              ),
            ],
            onClick: (menu, index) {
              context.vRouter.to(menu.route);
              scaffoldKey.currentState?.closeEndDrawer();
            },


          ),
        );
      },
    );
  }

}