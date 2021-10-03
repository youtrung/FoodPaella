
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/food_model.dart';

// class QuantityState {}
// class QuantityIncreState extends QuantityState {
//   Food? foodItems;
//   QuantityIncreState({this.foodItems});
// }
// class QuantityDecreState extends QuantityState {
//   Food? foodItems;
//   QuantityDecreState({this.foodItems});
// }

enum CounterEvent {
  increment,
  decrement
}


class QuantityBloc extends Bloc<CounterEvent,int> {
  Food food;
  QuantityBloc({required this.food}) : super(food.quantity);


  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch(event) {
      case CounterEvent.increment:
        food.quantity++;
        var newState = food.quantity;
        yield newState;
        break;
      case CounterEvent.decrement:
        food.quantity--;
        var newState = food.quantity;
        yield newState;
        break;
    }

  }

}

