

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/repositories/customer_repository.dart';
import 'package:food_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}
class InitialFormStatus extends FormSubmissionStatus{
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {
}
class SubmissionSuccess extends FormSubmissionStatus {
  CustomerModel? customerModel;
  SubmissionSuccess({this.customerModel});
}

class SubmissionFailed extends FormSubmissionStatus {
  final String exception;
  SubmissionFailed(this.exception);
}

class LoginState {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;
  bool get isValidEmail {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(this.email);
  }
  bool get isValidPass => this.password.length>0;
  LoginState({
    this.email='',
    this.password='',
    this.formStatus=const InitialFormStatus()
  });
  LoginState copyWith({String? email,String? password,FormSubmissionStatus? formStatus })
  {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus
    );
  }
}

abstract class LoginEvent {
}
class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {
  final CustomerModel? customerModel;
  LoginSubmitted({this.customerModel});
}

class Authentication extends LoginEvent {

}


class LoginBloc extends Bloc<LoginEvent,LoginState> {
  CustomerModel? customerModel=CustomerModel.initial();
  LoginBloc() : super(LoginState()) {

    on<EmailChanged> (
            (event,emit) => emit(state.copyWith(email: event.email))
    );
    on<PasswordChanged> ((event,emit) =>emit(state.copyWith(password: event.password)));
    on<LoginSubmitted> ((event,emit)  async {
      try {
        emit(state.copyWith(formStatus: FormSubmitting()));
        await Future.delayed(const Duration(seconds: 1));
        final customer =await APIWeb().post(CustomerRepository.getCustomerByEmailAndPassword(event.customerModel));
        final token =await APIWeb().post(CustomerRepository.saveToken(event.customerModel));
        SharedPreferences pref=await SharedPreferences.getInstance();
        await pref.setString("token",token!);
        await pref.setString("user",jsonEncode(customer));
        customerModel=customer;
        emit(state.copyWith(formStatus: SubmissionSuccess(customerModel: customer)));
      }catch(e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
        emit(state.copyWith(formStatus: InitialFormStatus()));
      }
    });
    on<Authentication> ( (event,emit)  async {
      try {
        emit(state.copyWith(formStatus: FormSubmitting()));
        SharedPreferences pref=await SharedPreferences.getInstance();
        String? token=pref.getString("token")!;
        final result =await APIWeb().get(CustomerRepository.getToken(token));
        if (result.toString() == "true") {
          CustomerModel user=CustomerModel.fromJSON(jsonDecode(pref.get("user").toString()));
          CustomerModel? customer =await APIWeb().post(CustomerRepository.getCustomerByEmailAndPassword(user));
          customerModel=customer;
          emit(state.copyWith(formStatus: SubmissionSuccess(customerModel: customer)));
        }else
          emit(state.copyWith(formStatus: InitialFormStatus()));
      }catch(e) {
        emit(state.copyWith(formStatus: InitialFormStatus()));

      }
    });
  }
}