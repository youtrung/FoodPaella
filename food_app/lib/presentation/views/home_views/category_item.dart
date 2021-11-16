import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/filter_category_bloc.dart';
import 'package:food_app/bloc/store_bloc.dart';
import 'package:food_app/constant/route_strings.dart';

import 'package:food_app/utils/helper.dart';

class CategoryItem extends StatelessWidget {
  final  String title;
  final String fileName;
  CategoryItem({Key? key, required this.title,required this.fileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          BlocProvider.of<FilterBloc>(context).add(FilterEvent(category:title));
          Navigator.pushNamed(context,FILTER_ROUTE,arguments: title);
        },
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
