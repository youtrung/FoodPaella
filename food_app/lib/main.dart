import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/search_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/presentation/router.dart';
import 'package:food_app/presentation/views/introduce_views/splash_view.dart';
import 'package:food_app/services/cloud_message_services.dart';
import 'bloc/filter_category_bloc.dart';
import 'bloc/food_bloc.dart';
import 'bloc/login_bloc.dart';
import 'bloc/navigator_bloc.dart';
import 'bloc/notification_bloc.dart';
import 'bloc/store_bloc.dart';
import 'constant/route_strings.dart';



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
          notificationBloc:notificationBloc,
          router:AppRouter(),
          navigatorKey: navigatorKey,
      ),
      ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  final GlobalKey<NavigatorState> navigatorKey;
  final NotificationBloc notificationBloc;
  MyApp({required this.router,required this.navigatorKey,required this.notificationBloc});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    notificationBloc.initialize(context);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      BlocProvider.of<NavigatorBloc>(context).add(NavigateToRateEvent(storeId: message.data["store_id"]));
    });
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

