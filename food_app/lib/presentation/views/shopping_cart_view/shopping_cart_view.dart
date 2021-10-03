import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/presentation/views/store_views/food_item.dart';

class ShoppingCart extends StatefulWidget {

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        builder: (context, state)=>
            Scaffold(
          appBar: AppBar(
            title: Text('Shopping Cart'),
            actions: [
              BlocProvider.of<CartBloc>(context).cartFood.length>0
                  ? IconButton(
                icon: Icon(CupertinoIcons.trash),
                onPressed: ()=>BlocProvider.of<CartBloc>(context).add(ClearCart()),
              )
                  : Container()
            ],
          ),
          body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Card(
                      color: Colors.lightBlueAccent,
                      elevation: 12,
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          child: Text('Total Products in cart: ${BlocProvider.of<CartBloc>(context).cartFood.length}', style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: BlocProvider.of<CartBloc>(context).cartFood.length,
                          itemBuilder: (context, idx){
                            Food _prd = BlocProvider.of<CartBloc>(context).cartFood[idx];
                          return Dismissible(
                              key:ObjectKey(_prd),
                              child: FoodItem(food: _prd)
                          );

                          }
                      ),
                    ),
                    BlocProvider.of<CartBloc>(context).cartFood.length>0
                        ? Card(
                      elevation: 12,
                      child: Container(
                        width: double.infinity,
                        color: Colors.deepOrange,
                        padding: EdgeInsets.all(12),
                        child: Text('Total Price: ', style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    )
                        : Container()
                  ],
                )
            ),
          ),
        )
    );
  }
}
