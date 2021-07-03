import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:poetryapp/services/poet_sevice.dart';
import 'package:poetryapp/splash_screen.dart';

import 'models/poet_model.dart';

SystemUiOverlayStyle uiStyle = SystemUiOverlayStyle.light.copyWith(
  statusBarColor: Colors.white,
);

void main() {
  SystemChrome.setSystemUIOverlayStyle(uiStyle);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  List<PoetItem> _poetList = PoetList([]).list;

  _preCache(DbQueryResponse res, BuildContext context) {
    PoetList poetListModel =  PoetList.fromJson(res.data);
    _poetList = poetListModel.list;
    for(PoetItem item in _poetList) {
      precacheImage(NetworkImage(item.image), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    PoetService.getPoets(page: 0, limit: 100).then((value) => _preCache(value, context));
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0;

    return MaterialApp(
      title: '青玉案',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashScreen(),
      builder: (BuildContext context, Widget? child) {
        return FlutterEasyLoading(child: child,);
      },
    );
  }
}



