import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/filter_category_bloc.dart';
import 'package:food_app/bloc/store_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/presentation/views/home_views/store_item.dart';
class FilterView extends StatelessWidget {
  String? typeOfFood;
   FilterView({Key? key,this.typeOfFood}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("$typeOfFood"),
        centerTitle: true,
      ),
      body:BlocBuilder<FilterBloc,FilterState>(
        builder: (context,filterState) {
          if (filterState is FilterSuccess) {
            if(filterState.stores!=null) {
              List<Store>? stores= BlocProvider.of<StoreBloc>(context).stores;
              return ListView(
                shrinkWrap: true,
                children:  filterState.stores!.map((e) {
                      return buildStoreItem(store: e);
                }).toList()
              );
            }else return CircularLoading();
          }else
            return CircularLoading();
        },
      ),
    );
  }
}
