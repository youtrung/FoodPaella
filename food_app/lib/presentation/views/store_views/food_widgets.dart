import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_quantity_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/models/food_model.dart';

class FoodWidgets extends StatefulWidget {
  Food food;
  FoodWidgets({required this.food});

  @override
  _FoodWidgetsState createState() => _FoodWidgetsState();
}

class _FoodWidgetsState extends State<FoodWidgets> {
  @override
  Widget build(BuildContext context) {

      // bool _isItemAlreadyAdded(Food product) =>
      //     BlocProvider.of<CartBloc>(context).cartFood.where((element)=>element.id==widget.food.id)
      //         .isNotEmpty;
    return
      Expanded(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<QuantityBloc,int>(
                builder: (context,state) {
                  return Text("${state}");
                }
            ),
            Container(
              height: 40,
              child: IconButton(
                onPressed: ()  {
                  context.read<QuantityBloc>().add(CounterEvent.increment);
                  BlocProvider.of<CartBloc>(context).add(AddToCart(food: widget.food));

                },
                icon: Icon(Icons.add),
              ),
            ),
            Container(
              height: 40,
              child: IconButton(
                onPressed: ()  {
                  if (widget.food.quantity ==1) {
                    BlocProvider.of<CartBloc>(context).add(DelCart(food: widget.food));
                    context.read<QuantityBloc>().add(CounterEvent.decrement);
                  }else
                  context.read<QuantityBloc>().add(CounterEvent.decrement);

                },
                icon: Icon(Icons.remove),
              ),
            ),
          ],
        ),
      )
    ;
  }
}

