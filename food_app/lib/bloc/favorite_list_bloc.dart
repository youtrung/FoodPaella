
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/repositories/customer_repository.dart';
import 'package:food_app/repositories/store_repository.dart';
import 'package:food_app/services/api_services.dart';

abstract class FavoriteEvent {}

class AddToFavorite extends FavoriteEvent{
  Store store;
  AddToFavorite({required this.store});
}
class GetFavoriteStores extends FavoriteEvent{
  GetFavoriteStores();
}

class FavoriteState {
  List<String>? favoriteStore;
  List<Store>? myStores;
  FavoriteState({this.favoriteStore,this.myStores});
}

class SuccessState extends FavoriteState{
  IconData? icondata;
  Color? color;
  List<String>? favoriteStore;
  List<Store>? myStores;
  SuccessState({this.icondata,this.color,this.favoriteStore,this.myStores});
}
class FailState extends FavoriteState {
  Error error;
  FailState({required this.error});
}


class FavoriteBloc extends Bloc<FavoriteEvent,FavoriteState> {
  CustomerModel? customerModel;
  List<Store> myListStore=[];
  FavoriteBloc({this.customerModel}) : super(FavoriteState(favoriteStore:customerModel!.loveStoreIds )) {
    on<GetFavoriteStores>((event,emit) async {
      try {
        final data =await APIWeb().post(StoreRepository.getFavoriteStores(customerModel));
        myListStore=data;
        emit(FavoriteState(myStores: myListStore));
      } catch (e) {
        emit(FailState(error: e as Error));
      }
    } );

    on<AddToFavorite> ( (event,emit) async {
      try {
        if (_isItemAlreadyAdded(event.store.id)) {
          customerModel!.loveStoreIds!.remove(event.store.id);
          if (_isStoreAlreadyAdded(event.store)) myListStore.remove(event.store);
          final data=await APIWeb().put(CustomerRepository.updateUser(customerModel));
          emit(SuccessState(
              icondata:Icons.favorite_outline_sharp,
              color: Colors.white,
              favoriteStore:customerModel!.loveStoreIds,
            myStores: myListStore
          )
          );
        }else{
          customerModel!.loveStoreIds!.add(event.store.id ?? "");
          myListStore.add(event.store);
          final data=await APIWeb().put(CustomerRepository.updateUser(customerModel));
          emit(SuccessState(icondata:Icons.favorite,color: Colors.red,
              favoriteStore:customerModel!.loveStoreIds,myStores: myListStore
          ));
        }
      }
      catch(e) {
        emit(FailState(error: e as Error));
      }
    }
    );
  }
  bool _isItemAlreadyAdded(String? store_id )  {
    if(customerModel!.loveStoreIds == null) {
      customerModel!.loveStoreIds=[];
    }
   return customerModel!.loveStoreIds!.where((item) => item == store_id)
        .isNotEmpty;
  }
  bool _isStoreAlreadyAdded(Store  store)  {
    return myListStore.where((item) => item == store)
        .isNotEmpty;
  }


  }



