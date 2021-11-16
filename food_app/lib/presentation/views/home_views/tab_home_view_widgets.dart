
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/search_bloc.dart';
import 'package:food_app/bloc/store_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/constant/widgets.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/presentation/views/home_views/category_item.dart';
import 'package:food_app/presentation/views/search_views/search_view.dart';
import 'package:food_app/utils/helper.dart';

import 'store_item.dart';

class TabHomeView extends StatefulWidget {
  TabHomeView({Key? key}) : super(key: key);

  @override
  _TabHomeViewState createState() => _TabHomeViewState();
}

class _TabHomeViewState extends State<TabHomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final listCategory=[
    CategoryItem(title: "Healthy", fileName: "diet.png"),
    CategoryItem(title: "Drinks", fileName: "drink.png"),
    CategoryItem(title: "Fast food", fileName: "food-truck.png"),
    CategoryItem(title: "Noddles", fileName: "noddles.png"),
    CategoryItem(title: "Cơm", fileName: "rice.png"),
    CategoryItem(title: "Snacks", fileName: "snack.png"),
    CategoryItem(title: "Traditional", fileName: "traditional-food.png"),
  ];

  List<Store> listStore=[];

  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      BlocConsumer<StoreBloc,StoreState>(
        listener: (BuildContext context, state) {  },
        builder: ( context,state) {
         return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
            {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  snap: true,
                  floating: true,
                  toolbarHeight: 50,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: Container(
                      width: Helper.getScreenWidth(context),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(StadiumBorder(
                                side: BorderSide(color: AppColor.yellow,width: 2.0)
                            ))
                        ),
                        icon:Icon(Icons.search,color: Colors.black,),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch(storeBloc:BlocProvider.of<SearchBloc>(context)));
                        },
                        label: Text("Search for food",style: TextStyle(color: Colors.black,fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Explored by Categories",style:TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return listCategory[index];
                      },
                      childCount: listCategory.length
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 10.0),
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    elevation: 0,
                    pinned: true,
                    title: TabBar(
                        isScrollable: true,
                        indicatorPadding: EdgeInsets.only(top: 20),
                        indicatorWeight: 4.0,
                        labelColor: Colors.black,
                        // indicatorColor: Colors.transparent,
                        unselectedLabelColor: Colors.grey,
                        unselectedLabelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50), // Creates border
                            color: AppColor.yellow
                        )
                        ,
                        controller: _tabController,
                        tabs: [
                          Text("Popular",),
                          Text("Newest",),
                          Text("High rated"),
                          Text("Others")
                        ]
                    ),
                    toolbarHeight: 40,
                    backgroundColor: Colors.white,
                    //collapsedHeight: 100,
                  ),
                ),
              ];
            },
            body:
            TabBarView(
              controller: _tabController,
              children: [
                state is SuccessStore ?
                state.stores!.length >0 ?
                ListView.builder(
                      padding: EdgeInsets.only(top: 30),
                     itemCount:state.stores!.length,
                     itemBuilder: (BuildContext context, int index) {
                       if(state is StoreState) {
                         if(state.stores != null) {
                           listStore=state.stores!;
                           listStore.sort((a,b)=>b.reviews!.length.compareTo(a.reviews!.length));
                           return buildStoreItem(store:state.stores![index],);
                         }else
                           return CircularLoading();
                       }else
                         return CircularLoading();
                     },
                   ) : CircularLoading() : CircularLoading() ,
                state is SuccessStore ?
                state.stores!.length >0 ?
                ListView.builder(
                  padding: EdgeInsets.only(top: 30),
                  itemCount:state.stores!=null ? state.stores!.length:0,
                  itemBuilder: (BuildContext context, int index) {
                    if(state is StoreState) {
                      if(state.stores != null) {
                        return buildStoreItem(store: state.stores!.reversed.toList()[index],);
                      }else
                        return CircularLoading();
                    }else
                      return CircularLoading();
                  },
                )  : CircularLoading() : CircularLoading(),
                state is SuccessStore ?
                state.stores!.length >0 ?
                ListView.builder(
                  padding: EdgeInsets.only(top: 30),
                  itemCount: state.stores!=null ? state.stores!.length:0,
                  itemBuilder: (BuildContext context, int index) {
                    if(state is StoreState) {
                      if(state.stores != null) {
                        listStore=state.stores!;
                        listStore.sort((a,b) {
                          double ta=0.0;
                          double tb=0.0;
                          a.reviews!.forEach((element) {
                            ta+=element.rate!;
                          });
                          b.reviews!.forEach((element) {
                            tb+=element.rate!;
                          });
                          var ra=ta/a.reviews!.length;
                          var rb=tb/b.reviews!.length;
                          return rb.compareTo(ra);
                        });
                        return buildStoreItem(store:state.stores![index],);
                      }else
                        return CircularLoading();
                    }else
                      return CircularLoading();
                  },
                ): CircularLoading() : CircularLoading(),
                Center(
                  child: Text(
                    'MILCHPPODUKE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
              ],

            ),
          );
        }

      ) ,
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new Container(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}