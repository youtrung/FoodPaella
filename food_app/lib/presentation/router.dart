
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/like_arguments.dart';
import 'package:food_app/presentation/views/home_views/home_view.dart';
import 'package:food_app/presentation/views/introduce_views/forgot_password_view.dart';
import 'package:food_app/presentation/views/introduce_views/login_view.dart';
import 'package:food_app/presentation/views/introduce_views/landing_view.dart';
import 'package:food_app/presentation/views/introduce_views/register_view.dart';
import 'package:food_app/presentation/views/introduce_views/splash_view.dart';
import 'package:food_app/presentation/views/my_account_views/address_view.dart';
import 'package:food_app/presentation/views/my_account_views/profile_view.dart';
import 'package:food_app/presentation/views/payment_views/payment_view.dart';
import 'package:food_app/presentation/views/shopping_cart_views/shopping_cart_view.dart';
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
        final args=settings.arguments as CustomerModel;
        return MaterialPageRoute(builder: (_)=> HomeView(customerModel:args,));
      case STORE_ROUTE:
        final args=settings.arguments as LikeArguments;
        return MaterialPageRoute(builder: (_)=>StoreView(likeArguments:args));
      case CART_ROUTE:
        final args=settings.arguments as CustomerModel;
        return MaterialPageRoute(builder: (_) => ShoppingCart(customerModel: args,));
      case PROFILE_ROUTE:
        final args=settings.arguments as CustomerModel;
        return MaterialPageRoute(builder: (_) => ProfileView(customerModel: args,));
      case ADDRESS_ROUTE:
        final args=settings.arguments as CustomerModel;
        return MaterialPageRoute(builder: (_) => AddressView(customerModel: args,));
      case BILL_ROUTE:
        final args=settings.arguments as CustomerModel;
        return MaterialPageRoute(builder: (_)=> PaymentView(customerModel: args,));
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}