import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/store_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/presentation/views/home_views/tab_home_view_widgets.dart';
import 'package:food_app/utils/helper.dart';

class HomeSection extends StatelessWidget {
  HomeSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Helper.getScreenHeight(context),
      padding: EdgeInsets.all(10),
      child: TabHomeView(),
    );
  }
}



