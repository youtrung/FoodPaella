
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartState {}
class LoadingState extends CartState {}
class SuccessState extends CartState {
  int? count;
  double? sumPrice;
  SuccessState({this.count,this.sumPrice});
}
class FailState extends CartState {
  Error fail;
  FailState({required this.fail});
}



abstract class CartEvent {}
class ClearCart extends CartEvent {

}

class AddToCart extends CartEvent {
  String? storeId;
  String? customerId;
  Food food;
  AddToCart({required this.food,this.storeId,this.customerId});
}

class DelCart extends CartEvent {
  String? storeId;
  String? customerId;
  Food food;
  DelCart({required this.food,this.storeId,this.customerId});
}

class CartBloc extends Bloc<CartEvent,CartState> {
  List<OrderModel> cartOrder=[];
  CustomerModel? user;
  CartBloc() : super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    yield LoadingState();
    try {
      if (event is AddToCart) {
        if (_isItemAlreadyAddedOrder(event.storeId ?? "")) {
         OrderModel? orderModel= cartOrder.where((element) => element.storeId==event.storeId).first;
         if(!_isFoodAlreadyInOrder(orderModel.foods,event.food)) {
           orderModel.foods!.add(event.food);
         }
        }
        else {
          SharedPreferences pref=await SharedPreferences.getInstance();
          user =CustomerModel.fromJSON(jsonDecode(pref.get("user").toString()));
          OrderModel orderModel=new OrderModel();
          orderModel.foods=[];
          orderModel.customerId=user!.id;
          orderModel.storeId=event.storeId;
          orderModel.date=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
          orderModel.foods!.add(event.food);
          cartOrder.add(orderModel);
        }
        // if(!_isItemAlreadyAdded(event.food)){
        //     cartFood.add(event.food);
        //   }
      }
      else if(event is DelCart) {
        if(event.food.quantity==0) {
          cartOrder.forEach((element) {element.foods!.remove(event.food);});
          // cartFood.remove(event.food);
        }
      }else if (event is ClearCart)
        {
          cartOrder.forEach((element) {element.foods!.forEach((element) { element.quantity=0;});});
          cartOrder=[];
        }
      yield SuccessState(count: totalProduct().toInt(),sumPrice: sumPrice());
    }
    catch(e) {
        yield FailState(fail: e as Error);
    }

  }

  // bool _isItemAlreadyAdded(Food product) =>
  //     cartFood.where((item) => item.id == product.id)
  //         .isNotEmpty;


  bool _isItemAlreadyAddedOrder(String storeId) =>
      cartOrder.where((element) => element.storeId==storeId).isNotEmpty;

  bool _isFoodAlreadyInOrder(List<Food>? orderFood,Food product) =>
      orderFood!.where((item) => item.id == product.id)
          .isNotEmpty;

  // void increaseQuantity(Food product) {
  //   Food food=cartFood.where((item) => item.id == product.id).first;
  //   cartFood.forEach((element) {
  //     if (element.id ==food.id) {
  //       element.quantity+=1;
  //     }
  //   });
  // }

  // void clearQuantity(Food prd) {
  //   List<Food> foods=cartFood.where((element) => element.quantity>0).toList();
  //   foods.forEach((element) {element.quantity=0;});
  // }

  double sumPrice() {
    double t=0;
    cartOrder.forEach((element) {
      element.foods!.forEach((element) {
        t+=element.quantity*element.price!.toDouble();
      });
    });
    return t;
  }

  double totalProduct() {
    double t=0;
    cartOrder.forEach((element) {
        t+=element.foods!.length;
    });
    return t;
  }


}

