import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_quantity_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/constant/my_icon.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/order_model.dart';

class FoodWidgets extends StatefulWidget {
  String? storeId;
  Food food;
  FoodWidgets({required this.food,this.storeId});

  @override
  _FoodWidgetsState createState() => _FoodWidgetsState();
}

class _FoodWidgetsState extends State<FoodWidgets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.only(top: 85),
        child: BlocBuilder<QuantityBloc,int>(
            builder: (context,state) {
              return Row(
                children: [
                  state >0 ?
                  IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,size: 30,),
                        onPressed: () {
                        context.read<QuantityBloc>().add(CounterEvent.decrement);
                        BlocProvider.of<CartBloc>(context).add(DelCart(food: widget.food));
                      }):
                  Padding(padding: EdgeInsets.only(left: 48)),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("$state",style: TextStyle(fontSize: 16),),
                  ),
                  IconButton(
                      icon: Icon(Icons
                          .keyboard_arrow_up,size: 30,),
                      onPressed: () {
                      context.read<QuantityBloc>().add(CounterEvent.increment);
                      BlocProvider.of<CartBloc>(context).add(AddToCart(food: widget.food,storeId: widget.storeId));
                      }),
                ],
              );
            }
        ),
      )
    ;
  }
}


//     Container(
//       height: 40,
//       child: IconButton(
//         onPressed: ()  {
//           context.read<QuantityBloc>().add(CounterEvent.increment);
//           BlocProvider.of<CartBloc>(context).add(AddToCart(food: widget.food));
//
//         },
//         icon: Icon(Icons.add),
//       ),
//     ),
//       state > 0 ?
//       Container(
//       height: 40,
//       child: IconButton(
//           onPressed: ()  {
//           if (widget.food.quantity ==1) {
//           BlocProvider.of<CartBloc>(context).add(DelCart(food: widget.food));
//           context.read<QuantityBloc>().add(CounterEvent.decrement);
//           }else
//           context.read<QuantityBloc>().add(CounterEvent.decrement);
//           },
//   icon: Icon(Icons.remove),
// ),
//       ):Container()
