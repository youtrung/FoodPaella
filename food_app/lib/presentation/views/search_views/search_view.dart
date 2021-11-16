
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/search_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/store_model.dart';


class DataSearch extends SearchDelegate<Store> {
  final Bloc<SearchEvent,SearchState> storeBloc;
  DataSearch({required this.storeBloc});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon:Icon(Icons.clear), onPressed: () {
        query="";
      },)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
      return IconButton(onPressed: () {
        close(context,Store.initial());
      }, icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      );
  }

  @override
  Widget buildResults(BuildContext context) {
      storeBloc.add(SearchEvent(text: query));
    return BlocBuilder<SearchBloc,SearchState>(
      builder: (context,stateSearch) {
        if (stateSearch is SearchLoadingState) {
          return CircularLoading();
        }else if (stateSearch is SearchSuccessState)
        {
          return ListView.builder(itemBuilder: (context,index)=>
              ListTile(
                onTap: () {
                  // LikeArguments likeArguments=LikeArguments(store: suggestionList[index],customerModel: customer);
                  Navigator.pushNamed(context, STORE_ROUTE,arguments:stateSearch.stores![index]);
                },
                title: Text(stateSearch.stores![index].name ?? ""),
                leading: Icon(Icons.store),
              ),
            itemCount: stateSearch.stores!.length,
          );
        }else if (stateSearch is SearchFailedState) {
          return Container(child: Text("not found"),);
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
    // if (query.length >0) {
    //   _debounce.run(() {
    //     storeBloc.add(SearchEvent(text: query));
    //   });
    // }
    // return BlocBuilder<SearchBloc,SearchState>(
    //   builder: (context,stateSearch) {
    //     if (stateSearch is SearchLoadingState) {
    //       return Container();
    //     }else if (stateSearch is SearchSuccessState)
    //     {
    //       return ListView.builder(itemBuilder: (context,index)=>
    //           ListTile(
    //             onTap: () {
    //               // LikeArguments likeArguments=LikeArguments(store: suggestionList[index],customerModel: customer);
    //               Navigator.pushNamed(context, STORE_ROUTE,arguments:stateSearch.stores![index]);
    //             },
    //             title: Text(stateSearch.stores![index].name ?? ""),
    //             leading: Icon(Icons.store),
    //           ),
    //         itemCount: stateSearch.stores!.length,
    //       );
    //     }else if (stateSearch is SearchFailedState) {
    //       return Container();
    //     }
    //     return Container();
    //   },
    // );
  }

}

