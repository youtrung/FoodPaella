import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/search_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/presentation/router.dart';
import 'package:food_app/presentation/views/introduce_views/splash_view.dart';
import 'bloc/filter_category_bloc.dart';
import 'bloc/food_bloc.dart';
import 'bloc/login_bloc.dart';
import 'bloc/store_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
          create:   (context)=>LoginBloc()
          ),
          BlocProvider<CartBloc>(
          create: (context)=>CartBloc(),
          ),
          BlocProvider<StoreBloc>(
            create: (context)=>StoreBloc()..add(GetStoresEvent()),
          ),
          BlocProvider<FoodBloc>(
            create: (context)=>FoodBloc()..add(getFoodEvent()),
          ),
        BlocProvider<UserBloc>(
        create: (context)=>UserBloc(),
        ),
          BlocProvider<FilterBloc>(
            create: (context)=>FilterBloc(),
          ),
          BlocProvider<SearchBloc>(
            create: (context)=>SearchBloc(),
          ),
        ],
        child: MyApp(
    router:AppRouter()
  ),
      ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  MyApp({required this.router});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        primaryColor: AppColor.yellow,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF1BA27),
        ),
        elevatedButtonTheme:
        ElevatedButtonThemeData(
            style:
            ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.yellow),
              shape: MaterialStateProperty.all(
                StadiumBorder(),
              ),
              elevation: MaterialStateProperty.all(0)
            ),
        ),

        textTheme: TextTheme(
            bodyText2: TextStyle(color: AppColor.secondary),
          headline6: TextStyle(
            color: AppColor.primary,
            fontSize: 25
          )
        )
      ),
      home: SplashView(),
      onGenerateRoute: router.generateRoute,
    );
  }
}

