import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/repositories/food_repository.dart';
import 'package:food_app/repositories/order_repository.dart';
import 'package:food_app/services/api_services.dart';

class PaymentState {
  List<OrderModel>? orders;
  PaymentState({this.orders});
}

class PaymentLoadingState extends PaymentState{
}
class PaymentSuccessState extends PaymentState{

}
class PaymentFailedState extends PaymentState{
  String error;
  PaymentFailedState({required this.error});
}





abstract class OrderEvent {}

class PaymentEvent extends OrderEvent {
  OrderModel? order;
  PaymentEvent({required this.order});
}

class GetPaymentEvent extends OrderEvent {
  String? userId;
  GetPaymentEvent({this.userId});
}

class GetPaymentDayToDay extends OrderEvent {
  String? userId;
  DateTime? startDate;
  DateTime? endDate;
  GetPaymentDayToDay({this.userId,this.startDate,this.endDate});
}



class PaymentBloc extends Bloc<OrderEvent,PaymentState> {
  List<OrderModel> orders=[];
  List<Food> foodList=[];
  PaymentBloc() : super(PaymentState()) {
    on<PaymentEvent> ( (event,emit) async {
      try {
        emit(PaymentLoadingState());
          final data=await APIWeb().post(OrderRepository.postOrder(event.order));
        emit(PaymentSuccessState());
      }catch(e) {
          emit(PaymentFailedState(error: e.toString()));
      }
    });
    on<GetPaymentEvent> ( (event,emit) async {
      try {
        emit(PaymentLoadingState());
        final data=await APIWeb().get(OrderRepository.getOrderById(event.userId ?? ""));
        orders=data;
        final foods=await APIWeb().get(FoodRepository.load());
        foodList=foods;
        emit(PaymentState(orders: data));
      }catch(e) {
          emit(PaymentFailedState(error: e.toString()));
      }
    });

    on<GetPaymentDayToDay> ( (event,emit) async {
      try {
        emit(PaymentLoadingState());
        final data=await APIWeb().post(OrderRepository.postOrderDayToDay(event.userId,event.startDate,event.endDate));
        orders=data!;
        final foods=await APIWeb().get(FoodRepository.load());
        foodList=foods;
        emit(PaymentState(orders: data));
      }catch(e) {
        emit(PaymentFailedState(error: e.toString()));
      }
    });

  }

}