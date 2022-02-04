import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/repositories/customer_repository.dart';
import 'package:food_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserEvent {}
class UserChangedEvent extends UserEvent {
  CustomerModel? customerModel;
  UserChangedEvent({this.customerModel});
}
class LogoutEvent extends UserEvent {

}
class ForgotPasswordEvent extends UserEvent {
String? email;
ForgotPasswordEvent({this.email});
}

class ResetPasswordEvent extends UserEvent {
  String? email;
  String? password;
  ResetPasswordEvent({this.email,this.password});
}

class UserState{
}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{
  String? email;
  CustomerModel? customerModel;
  UserSuccessState({this.customerModel,this.email});
}
class FailedState extends UserState {
  String? error;
  FailedState({this.error});
}

class UserBloc extends Bloc<UserEvent,UserState> {
  UserBloc() : super(UserState()) {
    on<UserChangedEvent> ((event,emit) async {
      try {
        emit(UserLoadingState());
        await Future.delayed(const Duration(seconds: 2));
        final data =await APIWeb().put(CustomerRepository.updateUser(event.customerModel));
        emit(UserSuccessState(customerModel:event.customerModel));
      }catch(e) {
        emit(FailedState(error: e.toString()));
      }

    });

    on<LogoutEvent> ((event,emit) async {
      try {
        emit(UserLoadingState());
        await Future.delayed(const Duration(seconds: 1));
        SharedPreferences pref=await SharedPreferences.getInstance();
        pref.clear();
        emit(UserSuccessState());
      }catch(e) {
        emit(FailedState(error: e.toString()));
      }

    });

    on<ForgotPasswordEvent> ((event,emit) async {
      try {
        await Future.delayed(const Duration(seconds: 2));
        final data =await APIWeb().post(CustomerRepository.forgotPassword(event.email));
      }catch(e) {
        emit(FailedState(error:"invalid email"));
      }
    });

    on<ResetPasswordEvent> ((event,emit) async {
      try {
        final data =await APIWeb().post(CustomerRepository.resetPassword(event.email,event.password));
      }catch(e) {
        print("update failed");
        emit(FailedState(error:"invalid email"));
      }
    });


  }
}