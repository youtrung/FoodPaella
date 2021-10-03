import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/presentation/views/home_views/category_item.dart';
import 'package:food_app/utils/helper.dart';

import 'store_item.dart';

class TabHomeView extends StatefulWidget {
  const TabHomeView({Key? key}) : super(key: key);

  @override
  _TabHomeViewState createState() => _TabHomeViewState();
}

class _TabHomeViewState extends State<TabHomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final listCategory=[
    CategoryItem(title: "Healthy", fileName: "diet.png"),
    CategoryItem(title: "Drinks", fileName: "drink.png"),
    CategoryItem(title: "Fast Foods", fileName: "food-truck.png"),
    CategoryItem(title: "Noddles", fileName: "noddles.png"),
    CategoryItem(title: "Rice", fileName: "rice.png"),
    CategoryItem(title: "Snacks", fileName: "snack.png"),
    CategoryItem(title: "Traditional", fileName: "traditional-food.png"),
  ];

  final listFood=[
    Food(id:1,nameFood: "Thuc an 1",description: "mo ta mon an",price: 18000,
    category:"Menu 1",imageFood: "bacsiu.jpg"),
    Food(id:2,nameFood: "Thuc an 2",description: "mo ta mon an",price: 18000,
        category:"Menu 1",imageFood: "americano.jpg"),
    Food(id:3,nameFood: "Thuc an 1",description: "mo ta mon an",price: 18000,
        category:"Menu 1",imageFood: "caphedaxay.jpg"),
    Food(id:4,nameFood: "Thuc an 1",description: "mo ta mon an",price: 18000,
        category:"Menu 2",imageFood: "mochikemchocolate.jpg"),
    Food(id:5,nameFood: "Thuc an 1",description: "mo ta mon an",price: 18000,
        category:"Menu 2",imageFood: "mochikemmatcha.jpg"),
    Food(id:6,nameFood: "Thuc an 1",description: "mo ta mon an",price: 18000,
        category:"Menu 2",imageFood: "mochikemxoai.jpg"),
    Food(id:7,nameFood: "Thuc an 1",description: "mo ta mon an",price: 18000,
        category:"Menu 2",imageFood: "mochikemxoai.jpg"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
        {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              title: AppBar(
                backgroundColor:Colors.white,
                title:Container(
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
                    print("you press this button");
                  },
                  label: Text("Search for food",style: TextStyle(color: Colors.black,fontSize: 20),),
                ),
              ),
              )
            ),
            SliverToBoxAdapter(
              child: Text("Explored by Categories",style:TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                color: Colors.black
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
            SliverAppBar(
              pinned: true,
              title: TabBar(
                  indicatorPadding: EdgeInsets.only(top: 20),
                  indicatorWeight: 4.0,
                  labelColor: Colors.green,
                  isScrollable: true,
                  // indicatorColor: Colors.transparent,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(
                    fontFamily:"Courgette",
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
                      color: Colors.greenAccent
                  )
                  ,
                  controller: _tabController,
                  tabs: [
                    Text("Popular",),
                    Text("Newwest",),
                    Text("High rated"),
                    Text("Others")
                  ]
              ),
              toolbarHeight: 40,
              backgroundColor: Colors.white,
              //collapsedHeight: 100,
            ),
        //     SliverPersistentHeader(
        //       pinned: false,
        //       delegate: MySliverPersistentHeaderDelegate(
        //           TabBar(
        //               indicatorWeight: 4.0,
        //               labelColor: Colors.green,
        // isScrollable: true,
        // // indicatorColor: Colors.transparent,
        // unselectedLabelColor: Colors.grey,
        // unselectedLabelStyle: TextStyle(
        // fontFamily:"Courgette",
        // fontSize: 16,
        // color: Colors.black,
        // fontWeight: FontWeight.w700,
        // ),
        // labelStyle: TextStyle(
        // color: Colors.black,
        // fontSize: 16,
        // fontWeight: FontWeight.bold,
        // ),
        // indicator: BoxDecoration(
        // borderRadius: BorderRadius.circular(50), // Creates border
        // color: Colors.greenAccent
        // )
        // ,
        // controller: _tabController,
        // tabs: [
        // Text("Popular",),
        // Text("Newwest",),
        // Text("High rated"),
        // Text("Others")
        // ]
        // ),
        //         ),
        //       ),
          ];
        },
          body:TabBarView(
          controller: _tabController,
          children: [
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 30),
              children: [
                buildStoreItem(
                  store: Store(
                      id:1,
                      imageStore:"login_screen_bg.png",
                      nameStore: "Cua hang thuc pham",
                    foods:listFood
                  ),
                ),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),
                buildStoreItem(store: Store(imageStore:"login_screen_bg.png",nameStore: "Cua hang thuc pham" ),),



              ],
            ),
            Center(
              child: Text(
                'KALTEGETRANKE',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                'HEIBGETRANKE',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                'MILCHPPODUKE',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
          ],

        ),
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