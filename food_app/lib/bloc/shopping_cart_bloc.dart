
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/food_model.dart';

class CartState {}
class LoadingState extends CartState {}
class SuccessState extends CartState {
  Food? foodItems;
  int? count;
  SuccessState({this.count,this.foodItems});
}
class IncreaseState extends CartState {
  int? quantity;
  IncreaseState({this.quantity});
}
class FailState extends CartState {
  Error fail;
  FailState({required this.fail});
}



abstract class CartEvent {}
class ClearCart extends CartEvent {

}

class AddToCart extends CartEvent {
  Food food;
  AddToCart({required this.food});
}

class DelCart extends CartEvent {
  Food food;
  DelCart({required this.food});
}

class CartBloc extends Bloc<CartEvent,CartState> {

  List<Food> cartFood=[];

  CartBloc() : super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    yield LoadingState();
    try {
      if (event is AddToCart) {
        if(!_isItemAlreadyAdded(event.food)){
            cartFood.add(event.food);
          }
      }else if(event is DelCart) {
        if(event.food.quantity==0){
          cartFood.remove(event.food);
        }
      }else if (event is ClearCart)
        {
          cartFood.forEach((element) {element.quantity=0;});
          cartFood = [];
        }
      yield SuccessState(count: cartFood.length);
    }
    catch(e) {
        yield FailState(fail: e as Error);
    }

  }

  bool _isItemAlreadyAdded(Food product) =>
      cartFood.where((item) => item.id == product.id)
          .isNotEmpty;
  void increaseQuantity(Food product) {
    Food food=cartFood.where((item) => item.id == product.id).first;
    cartFood.forEach((element) {
      if (element.id ==food.id) {
        element.quantity+=1;
      }
    });
  }

  void clearQuantity(Food prd) {
    List<Food> foods=cartFood.where((element) => element.quantity>0).toList();
    foods.forEach((element) {element.quantity=0;});
  }

}

