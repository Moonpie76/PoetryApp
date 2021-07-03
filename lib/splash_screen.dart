import 'dart:math';

import 'package:cloudbase_database/cloudbase_database.dart';
import 'package:flutter/material.dart';
import 'package:poetryapp/main.dart';
import 'package:poetryapp/services/ju_service.dart';
import 'package:poetryapp/services/poetry_form_idlist_service.dart';
import 'package:poetryapp/services/poetry_item_service.dart';
import 'models/ju_model.dart';
import 'models/poetry_model.dart';
import 'root_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
     _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => RootPage()), (route) => route==null);
      }
    });

    //使用控制器播放动画
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        'images/cover.jpg',
        scale: 2.0, //图片缩放
        fit: BoxFit.cover,
      ) ,
    );
  }
}
