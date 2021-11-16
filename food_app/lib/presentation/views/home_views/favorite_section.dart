import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/favorite_list_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/store_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/presentation/views/home_views/store_item.dart';

class FavoriteSection extends StatefulWidget {
  FavoriteSection({Key? key}) : super(key: key);

  @override
  State<FavoriteSection> createState() => _FavoriteSectionState();
}

class _FavoriteSectionState extends State<FavoriteSection> {

  @override
  Widget build(BuildContext context) {
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    return BlocProvider<FavoriteBloc>(
      create:(_)=> FavoriteBloc(customerModel: customer)..add(GetFavoriteStores()),
      child: BlocBuilder<FavoriteBloc,FavoriteState>(
                builder: (context,state) {
                  return ListView(
                    padding: EdgeInsets.only(top: 30),
                    children:
                    state is FavoriteState ?
                      state.myStores != null ?
                  state.myStores!.map((e)=>buildStoreItem(store:e,)).toList()
                      : state is SuccessState ?
                  state.myStores!.map((e)=>buildStoreItem(store:e,)).toList()
                      :[ CircularLoading()] :[ CircularLoading()]
                  );
                }

        ),
    );
  }
}
