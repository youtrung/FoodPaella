import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/repositories/store_repository.dart';
import 'package:food_app/services/api_services.dart';

class FilterEvent {
  String? category;
  FilterEvent({this.category});
}
class FilterState {
}
class FilterSuccess extends FilterState {
  List<Store>? stores=[];
  FilterSuccess({this.stores});
}
class FilterLoading extends FilterState {
}
class FilterFailed extends FilterState {
  String? error;
  FilterFailed({this.error});
}

class FilterBloc extends Bloc<FilterEvent,FilterState> {
  FilterBloc() : super(FilterState()) {
    on<FilterEvent> ((event,emit) async {
      try {
        emit(FilterLoading());
        await Future.delayed(const Duration(seconds: 1));
        final data=await APIWeb().get(StoreRepository.getStoresByCategory(event.category));
        emit(FilterSuccess(stores:data));
      }catch (e) {
        emit(FilterFailed(error:e.toString()));
      }
    });
  }

}