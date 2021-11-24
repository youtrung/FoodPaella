
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/review_list_bloc.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/like_arguments.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/presentation/views/home_views/main_view.dart';
import 'package:food_app/presentation/views/introduce_views/forgot_password_view.dart';
import 'package:food_app/presentation/views/introduce_views/login_view.dart';
import 'package:food_app/presentation/views/introduce_views/landing_view.dart';
import 'package:food_app/presentation/views/introduce_views/register_view.dart';
import 'package:food_app/presentation/views/introduce_views/splash_view.dart';
import 'package:food_app/presentation/views/my_account_views/address_view.dart';
import 'package:food_app/presentation/views/my_account_views/profile_view.dart';
import 'package:food_app/presentation/views/payment_views/payment_view.dart';
import 'package:food_app/presentation/views/search_views/filtered_view.dart';
import 'package:food_app/presentation/views/shopping_cart_views/shopping_cart_view.dart';
import 'package:food_app/presentation/views/store_views/rate_view.dart';
import 'package:food_app/presentation/views/store_views/store_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashView());
      case LANDING_ROUTE :
        return MaterialPageRoute(builder: (_)=> LandingView());
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_)=> LoginView());
      case REGISTER_ROUTE:
        return MaterialPageRoute(builder: (_)=> RegisterView());
      case FORGOT_PASSWORD_ROUTE:
        return MaterialPageRoute(builder: (_)=> ForgotPasswordView());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_)=> HomeView());
      case STORE_ROUTE:
        final args=settings.arguments as Store;
        return MaterialPageRoute(builder: (_)=>StoreView(store:args,));
      case CART_ROUTE:
        return MaterialPageRoute(builder: (_) => ShoppingCart());
      case PROFILE_ROUTE:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case ADDRESS_ROUTE:
        return MaterialPageRoute(builder: (_) => AddressView());
      case BILL_ROUTE:
        return MaterialPageRoute(builder: (_)=> PaymentView());
      case FILTER_ROUTE:
        final args=settings.arguments as String;
        return MaterialPageRoute(builder: (_)=> FilterView(typeOfFood:args,));
      case RATE_ROUTE:
        final args=settings.arguments as String?;
        return MaterialPageRoute(builder: (_)=> BlocProvider<ReviewBloc>(
            create: (context)=>ReviewBloc(),
            child: RateView(storeId: args,)
        ));
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}