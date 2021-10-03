
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/utils/helper.dart';


class SplashView extends StatefulWidget {
  const  SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    _timer=Timer(Duration(milliseconds: 4000),() {
      Navigator.of(context).pushReplacementNamed(LANDING_ROUTE);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:Helper.getScreenWidth(context),
        height:Helper.getScreenHeight(context),
        child: Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: new Image.asset(Helper.getAssetName(fileName:"splash_icon.png"),fit: BoxFit.fill,)
              ),
              Align(alignment: Alignment.center,child: Image.asset(Helper.getAssetName(fileName:"food_logo.png")),)
            ],
        ),
      ),
    );
  }
}
