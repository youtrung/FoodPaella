import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_quantity_bloc.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/presentation/views/store_views/food_widgets.dart';
import 'package:food_app/utils/helper.dart';
import 'package:intl/intl.dart';


class FoodItem extends StatelessWidget {
  String? storeId;
  Food food;
  FoodItem({Key? key,required this.food,this.storeId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat();

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
                        child: Image.network(food.image ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("${food.name}",
                          softWrap: true,
                          textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(),
                          Text("${formatCurrency.format(food.price)} VND",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              color: Colors.red
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    FoodWidgets(food: food,storeId: storeId,),

                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
