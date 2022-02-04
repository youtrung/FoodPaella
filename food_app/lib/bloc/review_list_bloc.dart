import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/rate_model.dart';
import 'package:food_app/repositories/customer_repository.dart';
import 'package:food_app/services/api_services.dart';

class ReviewEvent {}

class EventGetListReviewByStoreId extends ReviewEvent {
  String? storeId;
  EventGetListReviewByStoreId({this.storeId});
}

class EventGetReviewUserById extends ReviewEvent {
  String? customerId;
  EventGetReviewUserById({this.customerId});
}
class EventSendReview extends ReviewEvent {
  String? customerId;
  String? storeId;
  double? rate;
  EventSendReview({this.customerId,this.storeId,this.rate});
}
class ReviewState {}
class ReviewFailedState extends ReviewState  {
  String? error;
  ReviewFailedState({this.error});
}
class ReviewLoadingState extends ReviewState  {}
class ReviewUsersState extends ReviewState {
  List<CustomerModel>? users=[];
  List<RateModel>? reviews=[];
  ReviewUsersState({this.users,this.reviews});
}
class ReviewBloc extends Bloc<ReviewEvent,ReviewState> {
  List<CustomerModel>? users=[];
  ReviewBloc() : super(ReviewState()) {
    on<EventGetReviewUserById> ((event,emit) async {
      try {
        emit(ReviewLoadingState());
        await Future.delayed(const Duration(seconds: 2));
          CustomerModel? data=await APIWeb().get(CustomerRepository.getCustomerById(event.customerId ??""));
          if (data != null) {
            users!.add(data);
          }else {
            CustomerModel user =new CustomerModel(id:event.customerId,name: "anonymous");
            users!.add(user);
          }
        emit(ReviewUsersState(users:users));
      }catch (e) {
        emit(ReviewFailedState(error: e.toString()));
      }
    });

    on<EventSendReview> ((event,emit) async {
      try {
        RateModel rateModel=new RateModel();
        rateModel.store_id=event.storeId;
        rateModel.customer_id=event.customerId;
        rateModel.rate=event.rate!;
        await APIWeb().post(CustomerRepository.commentStore(rateModel));
        print("review success");
      }catch (e) {
        print("review failed");
      }
    });

    on<EventGetListReviewByStoreId> ((event,emit) async {
      try {
        emit(ReviewLoadingState());
        await Future.delayed(const Duration(seconds: 2));
        final data=await APIWeb().get(CustomerRepository.getReviewsStore(event.storeId));
        emit(ReviewUsersState(reviews: data));
      }catch (e) {
        emit(ReviewFailedState(error: e.toString()));
      }
    });

  }

}