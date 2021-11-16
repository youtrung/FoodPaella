import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/favorite_list_bloc.dart';
import 'package:food_app/bloc/food_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/review_list_bloc.dart';
import 'package:food_app/constant/back-ground-image.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/presentation/views/store_views/info_section.dart';
import 'package:food_app/presentation/views/store_views/review_section.dart';
import 'package:food_app/utils/helper.dart';

import 'group_list_view.dart';

class StoreView extends StatefulWidget {
  Store? store;
  StoreView({Key? key,this.store}): super(key: key);

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
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    List<Food> foods=[];
          return Scaffold(
              body: BlocProvider<FavoriteBloc>(
                create: (context) =>FavoriteBloc(customerModel:customer),
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
                                      BlocProvider.of<FavoriteBloc>(context).add(AddToFavorite(store: widget.store!));
                                    },
                                    icon: state is FavoriteState ?
                                        _isItemAlreadyLike(widget.store!.id) ?
                                          Icon(Icons.favorite,color: Colors.red,):
                                          state is SuccessState ? Icon(state.icondata,color: state.color,):
                                          Icon(Icons.favorite_outline_sharp,color: Colors.white,) :
                                    Icon(Icons.favorite_outline_sharp,color: Colors.white,)
                                );
                              }
                          )
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: BackgroundImage(image:widget.store!.image ?? ""),
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
                                  if(widget.store!.foods!.contains(food.id)){
                                    foods.add(food);
                                    return foods;
                                  }
                                  return foods;
                                }).toList() ;
                                return GroupFood(foods: foods,storeId: widget.store!.id,);
                              }
                              return CircularLoading();
                            }else if (state is FailureFood) {
                              return Container(child: Center(child: Text("Lỗi"),),);
                            }else
                              return  CircularLoading();
                          }
                      ),
                      BlocProvider<ReviewBloc>(
                          create: (_) {
                            return ReviewBloc();
                          },
                          child: ReviewSection(store: widget.store,)
                      ),
                      InfoSection(store: widget.store,),
                    ],
                  ),
                ),
              )
          );
  }

}