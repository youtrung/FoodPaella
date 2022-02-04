import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/shop_cart_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/food_model.dart';


import 'card_item_widget.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart();
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  @override
  Widget build(BuildContext context) {
    var orderList=BlocProvider.of<CartBloc>(context).cartOrder;
    List<Food> foodList=[];
    orderList.forEach((element) { element.foods!.forEach((f) { foodList.add(f); }); });
    return BlocBuilder<CartBloc, CartState>(
        builder: (context, state)=>
            Scaffold(
              appBar: AppBar(
                title: Text('Shopping Cart'),
              backgroundColor: AppColor.yellow,
              actions: [
                foodList.length>0
                  ? IconButton(
                icon: Icon(CupertinoIcons.trash),
                onPressed: ()=>BlocProvider.of<CartBloc>(context).add(ClearCart()),
              )
                  : Container()
            ],
          ),
              body: CardItemWidgets()
        )
    );
  }
}
