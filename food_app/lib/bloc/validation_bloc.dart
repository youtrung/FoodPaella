import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/repositories/customer_repository.dart';
import 'package:food_app/services/api_services.dart';

class ValidateState {}
class ValidateSuccess extends ValidateState {
  String? result;
  ValidateSuccess({this.result});
}
class ValidateFailure extends ValidateState {
  String error;
  ValidateFailure({required this.error});
}
class ValidateEvent {
  int code;
  String email;
  ValidateEvent({required this.code,required this.email});
}

class ValidateBloc extends Bloc<ValidateEvent,ValidateState> {
  ValidateBloc() : super(ValidateState()) {
    on<ValidateEvent> ((event,emit) async {
      try {
        final data=await APIWeb().post(CustomerRepository.checkVerificationCode(event.email,event.code));
        if (data == true){
          emit(ValidateSuccess());
        }else emit(ValidateFailure(error: 'false'));
      }catch(e) {
        emit(ValidateFailure(error: e.toString()));
      }

    });
  }


}