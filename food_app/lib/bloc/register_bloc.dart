

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  final Exception exception;
  SubmissionFailed(this.exception);
}

class RegisterState {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;
  bool get isValidEmail {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(this.email);
  }
  bool get isValidPass => this.password.length>0;
  RegisterState({
    this.email='',
    this.password='',
    this.formStatus=const InitialFormStatus()
  });
  RegisterState copyWith({String? email,String? password,FormSubmissionStatus? formStatus })
  {
    return RegisterState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus
    );
  }
}

abstract class RegisterEvent {
}
class EmailChanged extends RegisterEvent {
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends RegisterEvent {
  final String password;
  PasswordChanged({required this.password});
}

class RegisterSubmitted extends RegisterEvent {
  final CustomerModel? customerModel;
  RegisterSubmitted({this.customerModel});
}


class RegisterBloc extends Bloc<RegisterEvent,RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<EmailChanged> (
            (event,emit) => emit(state.copyWith(email: event.email))
    );

    on<PasswordChanged> ((event,emit) =>emit(state.copyWith(password: event.password)));
    on<RegisterSubmitted> ((event,emit)  async {
      try {
        emit(state.copyWith(formStatus: FormSubmitting()));
        await Future.delayed(const Duration(seconds: 1));
        final data =await APIWeb().post(CustomerRepository.createCustomerWithEmailAndPassword(event.customerModel));
        final token =await APIWeb().post(CustomerRepository.saveToken(event.customerModel));
        SharedPreferences pref=await SharedPreferences.getInstance();
        await pref.setString("token",token!);
        await pref.setString("user",jsonEncode(data));
        emit(state.copyWith(formStatus: SubmissionSuccess(customerModel: data)));
      }catch(e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      }
    }

    );
  }
}