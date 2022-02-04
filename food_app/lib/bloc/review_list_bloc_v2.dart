import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/review_model.dart';
import 'package:food_app/repositories/customer_repository.dart';
import 'package:food_app/services/api_services.dart';

class CommentEvent {}


class EventGetCommentUserById extends CommentEvent {
  String? storeId;
  String? customerId;
  double? rate;
  EventGetCommentUserById({this.customerId,this.storeId,this.rate});
}
class EventSendComment extends CommentEvent{
  String? customerId;
  String? storeId;
  double? rate;
  EventSendComment({this.customerId,this.storeId,this.rate});
}
class CommentState {}
class CommentFailedState extends CommentState  {
  String? error;
  CommentFailedState({this.error});
}
class CommentLoadingState extends CommentState  {}
class CommentUsersState extends CommentState {
  List<ReviewModel>? users=[];
  CommentUsersState({this.users});



}
class CommentBloc extends Bloc<CommentEvent,CommentState> {
  List<ReviewModel>? users=[];
  CommentBloc() : super(CommentState()) {
    on<EventGetCommentUserById> ((event,emit) async {
      try {
        emit(CommentLoadingState());
        await Future.delayed(const Duration(seconds: 2));
        if (_isCommentAlreadyAdded(event.storeId,event.customerId,event.rate)) {
          emit(CommentUsersState(users:users));
        }else {
          ReviewModel data =new ReviewModel();
          data.storeId=event.storeId;
          data.rate=event.rate;
          data.customerModel=await APIWeb().get(CustomerRepository.getCustomerById(event.customerId ??""));
          if (data.customerModel != null) {
            users!.add(data);
          }else {
            data.customerModel=new CustomerModel(id:event.customerId,name: "anonymous");
            users!.add(data);
          }
          emit(CommentUsersState(users:users));
        }

      }catch (e) {
        emit(CommentFailedState(error: e.toString()));
      }
    });


  }
  bool _isCommentAlreadyAdded(String? storeId,String? userId,double? rate) =>
      users!.where((element) => element.storeId==storeId && element.customerModel!.id==userId
          && element.rate==rate ).isNotEmpty;


}