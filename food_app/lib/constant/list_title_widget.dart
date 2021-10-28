import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/route_strings.dart';

class ListTileWidget extends StatelessWidget {
  String? urlStr;
  String? title;
  String routeStr;
  Object? args;
  ListTileWidget({Key? key,this.title,this.urlStr,required this.routeStr,this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(urlStr ?? ""),
      ),
      title: Text(title??"",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
      onTap: () {
        Navigator.pushNamed(context,routeStr,arguments: args);
      },
    );
  }
}
