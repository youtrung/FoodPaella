import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food_bloc.dart';
import 'package:food_app/bloc/payment_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/models/food_model.dart';
import 'package:food_app/models/order_model.dart';
import 'package:intl/intl.dart';


class OngoingOrderView extends StatefulWidget {
  OngoingOrderView({Key? key}) : super(key: key);

  @override
  _OngoingOrderViewState createState() => _OngoingOrderViewState();
}

class _OngoingOrderViewState extends State<OngoingOrderView> {
  List<Food> listFood=[];
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat();
    return BlocBuilder<PaymentBloc,PaymentState>(
        builder: (context,payState) {
          if (payState is PaymentLoadingState) {
           return CircularLoading();
          }if (payState is PaymentState) {
            List<OrderModel> cartOrder=BlocProvider.of<PaymentBloc>(context).orders;
            List<Food> foodList=BlocProvider.of<PaymentBloc>(context).foodList;
           return ListView.builder(
                itemCount:cartOrder.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10),
             itemBuilder: (BuildContext context, int index) {
                  if(cartOrder[index].status=="Đang giao") {
                    return Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: cartOrder[index].foods!.length,
                            itemBuilder: (BuildContext context, int foodIdx) {
                              if (foodList.length > 0) {
                                Food food = foodList
                                    .where((element) =>
                                element.id ==
                                    cartOrder[index].foods![foodIdx].id)
                                    .single;
                                return
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child:
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text("${food.name}"),
                                                Text(
                                                    "Quantity: ${cartOrder[index]
                                                        .foods![foodIdx]
                                                        .quantity}"),
                                                Text("Price:${cartOrder[index]
                                                    .foods![foodIdx].price} "),
                                                Text("Date: ${DateFormat(
                                                    "dd-MM-yyyy").format(
                                                    cartOrder[index].date!)}")
                                              ],
                                            ),
                                          ),
                                          Text("${cartOrder[index].status}")
                                        ],
                                      ),
                                    ),
                                  );
                              } else {
                                return Container();
                              }
                            }
                        ),
                      ],
                    );
                  }else {
                    return Container(
                    );
                  }
             },
            );
          }else
            return Container();
        }
    );
  }
}
