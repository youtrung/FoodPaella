import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/constant/my_icon.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/presentation/views/home_views/home_section.dart';



class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();

}

class _HomeViewState extends State<HomeView> {
int _currentIndex=0;


  final screens=[
    HomeSection(),
    Container(),
    Container(),
    Container(),
    Container()
  ];
  final titleScreens=[
    Text("Home Page"),
    Text("My Orders"),
    Text("My Favorites"),
    Text("Notification"),
    Text("My Account")
  ];


  @override
  Widget build(BuildContext context) {
    final  List<List<Widget>> actionScreens=
    [
      [
        Stack(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: BlocBuilder<CartBloc,CartState>(
                    builder: (context,state)=>state is LoadingState
                        ? CupertinoActivityIndicator()
                        : state is SuccessState
                        ? Text("${state.count}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),)
                        : state is FailState ?
                    Tooltip(message: '${state.fail.toString()}',child:Text("0"))
                        :Text("0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),),
                )
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context,CART_ROUTE);
                  },
                  icon: Icon(CupertinoIcons.shopping_cart)),
            ),
          ],
        ),
      ],
      [],
      [],
      [],
      [],
    ];




    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        onTap: (index)  {
          setState(() {
            _currentIndex=index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(MyIcon.order),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Likes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_rounded),
            label: "Me",
          ),
        ],
      ),
      appBar: AppBar(
        title: titleScreens[_currentIndex],
        centerTitle: true,
        actions: actionScreens[_currentIndex],
        backgroundColor: Color(0xFFF1BA27),
      ),
      body:screens[_currentIndex]
    );
  }

}






