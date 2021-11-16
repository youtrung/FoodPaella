import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/repositories/store_repository.dart';
import 'package:food_app/services/api_services.dart';
class StoreBloc extends Bloc<StoreEvent,StoreState> {
  List<Store>? stores=[];
  StoreBloc() : super(StoreState(stores: [])) {
    on<GetStoresEvent> ((event,emit) async {
      try {
        emit(LoadingStore());
        await Future.delayed(const Duration(seconds: 1));
        final data=await APIWeb().get(StoreRepository.load());
        stores=data;
        emit(SuccessStore(stores: stores));
      }catch (e) {
        emit(FailureStore(e.toString()));
      }
    });

  }


}




abstract class StoreEvent {}
class GetStoresEvent extends StoreEvent {
}


class StoreState {
   List<Store>? stores=[];

   StoreState({this. stores});

  factory StoreState.initial() => StoreState();
}
class SuccessStore extends StoreState {
  List<Store>? stores=[];
  SuccessStore({this. stores});
}


class FailureStore extends StoreState {
  final String error;
  FailureStore(this.error);
}

class LoadingStore extends StoreState {}