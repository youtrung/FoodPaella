import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/constant/route_strings.dart';

class NavigatorBloc extends Bloc<NavigatorAction, dynamic>{

  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({required this.navigatorKey}) : super(null);

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    if(event is NavigatorActionPop){
      navigatorKey.currentState!.pop();

    }else if(event is NavigateToRateEvent){
      navigatorKey.currentState!.pushNamed(RATE_ROUTE,arguments: event.storeId);
    }
  }
}

class NavigatorAction {
}
class NavigatorActionPop extends  NavigatorAction {

}
class NavigateToRateEvent extends  NavigatorAction {
String? storeId;
NavigateToRateEvent({this.storeId});
}