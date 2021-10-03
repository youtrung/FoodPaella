import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_quantity_bloc.dart';
import 'package:food_app/bloc/shopping_cart_bloc.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/presentation/views/store_views/food_widgets.dart';
import 'package:food_app/utils/helper.dart';

class FoodItem extends StatelessWidget {
  Food food;
  FoodItem({Key? key,required this.food}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>QuantityBloc(food: food),
      child: InkWell(
        onTap: () {

        },
        child: Container(
          margin:EdgeInsetsDirectional.fromSTEB(20,0, 20, 40),
          child:AspectRatio(
            aspectRatio: 3/1,
            child:Container(
              child:Row(
                  children: [
                    AspectRatio(
                      aspectRatio:1/1,
                      child: ClipRRect(
                        borderRadius:BorderRadius.circular(10),
                        child: Image.asset(Helper.getAssetName(fileName:food.imageFood ?? "",type: "food"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("${food.nameFood}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Spacer(),
                        Text("${food.price}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            color: Colors.red
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    FoodWidgets(food: food),

                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
