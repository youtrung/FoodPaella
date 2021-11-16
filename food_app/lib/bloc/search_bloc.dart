import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/repositories/store_repository.dart';
import 'package:food_app/services/api_services.dart';

class SearchEvent {
  String? text;
  SearchEvent({this.text});
}
class SearchState{}
class SearchSuccessState extends SearchState {
  List<Store>? stores=[];
  SearchSuccessState({this.stores});
}
class SearchFailedState extends SearchState {
String? error;
SearchFailedState({this.error});
}
class SearchLoadingState extends SearchState {}
class SearchBloc extends Bloc<SearchEvent,SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchEvent> ((event,emit) async {
      try {
        emit(SearchLoadingState());
        await Future.delayed(const Duration(seconds: 2));
        final data=await APIWeb().get(StoreRepository.getStoresByFoodName(event.text));
        emit(SearchSuccessState(stores:data));
      }catch (e) {
        emit(SearchFailedState(error: e.toString()));
      }
    }
    );
  }

}