
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Helper {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static String getAssetName({required String fileName,String? type}) {
    if (type==null) {
      return "assets/images/${fileName}";
    }else
    return "assets/images/${type}/${fileName}";
  }
  static TextTheme getTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }
}