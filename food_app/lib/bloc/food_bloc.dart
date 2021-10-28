import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/repositories/food_repository.dart';
import 'package:food_app/services/api_services.dart';
class FoodBloc extends Bloc<FoodEvent,FoodState> {
  List<Food> foods=[];
  FoodBloc() : super(FoodState()) {
    on<getFoodEvent> ((event,emit) async {
      try {
        emit(LoadingFood());
        await Future.delayed(const Duration(seconds: 1));
        final data=await APIWeb().get(FoodRepository.load());
        foods=data;
        emit(FoodState(foods: data));
      }catch (e) {
        emit(FailureFood(e.toString()));
      }


    });
  }


}

abstract class FoodEvent{}
class getFoodEvent extends FoodEvent {
}


class FoodState {
  List<Food>? foods=[];

  FoodState({this.foods});

  factory FoodState.initial() => FoodState();
}

class FailureFood extends FoodState {
  final String error;
  FailureFood(this.error);
}

class LoadingFood extends FoodState {}