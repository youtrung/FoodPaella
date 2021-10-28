import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/like_arguments.dart';
import 'package:food_app/models/store_model.dart';


class DataSearch extends SearchDelegate<Store> {
  CustomerModel? customerModel;
  List<Store>? listStore;
  DataSearch({this.listStore,this.customerModel});
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
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList=query.isEmpty?<Store>[]:listStore!.where((element) => element.name!.startsWith(query[0].toUpperCase())).toList();
    return ListView.builder(itemBuilder: (context,index)=>
        ListTile(
          onTap: () {
            LikeArguments likeArguments=LikeArguments(store: suggestionList[index],customerModel: customerModel);
            Navigator.pushNamed(context, STORE_ROUTE,arguments: likeArguments);
          },
            leading: Icon(Icons.store),
            title: RichText(
            text:TextSpan(
              text:suggestionList[index].name!.substring(0,query.length),
              style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].name!.substring(query.length),
                  style: TextStyle(color:Colors.grey)
                )
              ]
            ),
        ),
        ),
        itemCount: suggestionList.length,
    );
  }

}
