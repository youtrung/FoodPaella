
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/presentation/views/home_views/home_view.dart';
import 'package:food_app/presentation/views/introduce_views/forgot_password_view.dart';
import 'package:food_app/presentation/views/introduce_views/login_view.dart';
import 'package:food_app/presentation/views/introduce_views/landing_view.dart';
import 'package:food_app/presentation/views/introduce_views/register_view.dart';
import 'package:food_app/presentation/views/introduce_views/splash_view.dart';
import 'package:food_app/presentation/views/shopping_cart_view/shopping_cart_view.dart';
import 'package:food_app/presentation/views/store_views/home_store.dart';

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
        return MaterialPageRoute(builder: (_)=>StoreView(store: args,));
      case CART_ROUTE:
        return MaterialPageRoute(builder: (_) => ShoppingCart());
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}