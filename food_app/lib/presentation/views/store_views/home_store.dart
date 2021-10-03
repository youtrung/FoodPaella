import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/utils/helper.dart';

import 'group_list_view.dart';

class StoreView extends StatefulWidget {
  Store store;
  StoreView({required this.store});

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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(Helper.getAssetName(fileName: widget.store.imageStore ?? "" ),
                    fit:BoxFit.cover ,),
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
                labelColor: Colors.red,
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
            GroupFood(foods: widget.store.foods ?? [],),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}