
import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/src/models/ui/MyLocale.dart';

class AppState extends ChangeNotifier{

  List<MyLocale> localeList = [];


  void loadLocales(){
    // if(localeList.isEmpty) {
    //   DefaultAssetBundle.of(context).loadString("assets/locales.json").then((value) {
    //     List<dynamic> list = json.decode(value);
    //     setState(() {
    //       localeList = list.map((l) => MyLocale.fromJson(l)).toList();
    //     });
    //   },);
    //
    // }
  }
}