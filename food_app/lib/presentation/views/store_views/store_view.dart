import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/favorite_list_bloc.dart';
import 'package:food_app/bloc/food_bloc.dart';
import 'package:food_app/constant/back-ground-image.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/like_arguments.dart';
import 'package:food_app/utils/helper.dart';

import 'group_list_view.dart';

class StoreView extends StatefulWidget {
  LikeArguments? likeArguments;
  StoreView({Key? key,this.likeArguments}): super(key: key);

  @override
  _StoreViewState createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Food> foods=[];
          return Scaffold(
              body: BlocProvider<FavoriteBloc>(
                create: (context) =>FavoriteBloc(customerModel: widget.likeArguments!.customerModel),
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 200,
                        actions: [
                          BlocBuilder<FavoriteBloc,FavoriteState>(
                              builder: (context,state) {
                               final listFav=state.favoriteStore;
                               bool _isItemAlreadyLike(String? store_id ) =>
                                   listFav!.where((item) => item == store_id)
                                       .isNotEmpty;
                                return IconButton(
                                    onPressed: () {
                                      BlocProvider.of<FavoriteBloc>(context).add(AddToFavorite(store: widget.likeArguments!.store!));
                                    },
                                    icon: state is FavoriteState ?
                                        _isItemAlreadyLike(widget.likeArguments!.store!.id) ?
                                          Icon(Icons.favorite,color: Colors.red,):
                                          state is SuccessState ? Icon(state.icondata,color: state.color,):
                                          Icon(Icons.favorite_outline_sharp,color: Colors.white,) :
                                    Icon(Icons.favorite_outline_sharp,color: Colors.white,)
                                );
                              }
                          )
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: BackgroundImage(image: Helper.getAssetName(fileName: widget.likeArguments!.store!.image ?? "")),
                        ),
                        forceElevated: innerBoxIsScrolled,
                        backgroundColor: Colors.white,
                      ),
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        snap: true,
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        title: TabBar(
                          labelPadding: EdgeInsets.zero,
                          labelColor: Colors.green,
                          indicatorColor: Colors.green,
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelColor: Colors.black,
                          tabs: <Tab>[
                            Tab(text:'HOME'),
                            Tab(text:'REVIEW'),
                            Tab(text:"INFO"),
                          ],
                          controller: _tabController,
                        ),

                      )
                    ];
                  },
                  body:TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      BlocBuilder<FoodBloc,FoodState>(
                          builder: (context, state) {
                            if(state is FoodState) {
                              if (state.foods != null)
                              {
                                state.foods!.map((food) {
                                  if(widget.likeArguments!.store!.foods!.contains(food.id)){
                                    foods.add(food);
                                    return foods;
                                  }
                                  return foods;
                                }).toList() ;
                                return GroupFood(foods: foods,storeId: widget.likeArguments!.store!.id,);
                              }
                              return CircularLoading();
                            }else if (state is FailureFood) {
                              return Container(child: Center(child: Text("Lỗi"),),);
                            }else
                              return  CircularLoading();
                          }


                      ),
                      Container(),
                      Container(),
                    ],
                  ),
                ),
              )
          );
  }

}