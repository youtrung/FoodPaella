import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:food_app/utils/helper.dart';

class CategoryItem extends StatelessWidget {
  final  String title;
  final String fileName;
  CategoryItem({Key? key, required this.title,required this.fileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Helper.getAssetName(fileName: fileName,type: "category"),
              fit: BoxFit.cover,width: 50,height: 50,
            ),
            Text(title,style: TextStyle(color:Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
