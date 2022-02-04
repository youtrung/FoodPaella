import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/search_bloc.dart';
import 'package:food_app/bloc/shop_cart_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/presentation/router.dart';
import 'package:food_app/presentation/views/introduce_views/splash_view.dart';
import 'bloc/filter_category_bloc.dart';
import 'bloc/food_bloc.dart';
import 'bloc/login_bloc.dart';
import 'bloc/navigator_bloc.dart';
import 'bloc/notification_bloc.dart';
import 'bloc/review_list_bloc.dart';
import 'bloc/review_list_bloc_v2.dart';
import 'bloc/validation_bloc.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   FirebaseMessaging.instance
       .getInitialMessage();

  NotificationBloc notificationBloc = new NotificationBloc();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<NavigatorBloc>(
              create:   (context)=>  NavigatorBloc(navigatorKey:navigatorKey)
          ),
          BlocProvider.value(value: notificationBloc),
          BlocProvider<LoginBloc>(
          create:   (context)=>LoginBloc()
          ),
          BlocProvider<CartBloc>(
          create: (context)=>CartBloc(),
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
          BlocProvider<ReviewBloc>(
          create: (context)=>ReviewBloc()
          ),
          BlocProvider<CommentBloc>(
              create: (context)=>CommentBloc()
          ),
          BlocProvider<ValidateBloc>(
              create: (context)=>ValidateBloc()
          )
        ],
        child: MyApp(
          router:AppRouter(),
          navigatorKey: navigatorKey,
      ),
      ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  final GlobalKey<NavigatorState> navigatorKey;
  MyApp({required this.router,required this.navigatorKey});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: navigatorKey,
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

