import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/presentation/router.dart';
import 'package:food_app/presentation/views/introduce_views/splash_view.dart';
import 'bloc/food_bloc.dart';
import 'bloc/store_bloc.dart';

void main() {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(
          create: (context)=>CartBloc(),
          ),
          BlocProvider<StoreBloc>(
            create: (context)=>StoreBloc()..add(getStoresEvent()),
          ),
          BlocProvider<FoodBloc>(
            create: (context)=>FoodBloc()..add(getFoodEvent()),
          ),
        BlocProvider<UserBloc>(
        create: (context)=>UserBloc(),
        )
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

